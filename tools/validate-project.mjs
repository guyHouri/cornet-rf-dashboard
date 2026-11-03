import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import vm from "node:vm";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(here, "..");
const htmlPath = path.join(root, "dist", "index.html");
const samplePath = path.join(root, "data", "example-flash.csv");

const html = fs.readFileSync(htmlPath, "utf8");
assert.match(html, /<title>מדידות RF<\/title>/, "The page title is missing or unexpected");

for (const id of ["peak-value", "average-value", "peak-frequency", "sample-count", "file-input", "interval"]) {
  assert.match(html, new RegExp(`id=["']${id}["']`), `Missing required element: ${id}`);
}

const inlineScripts = [...html.matchAll(/<script(?:\s[^>]*)?>([\s\S]*?)<\/script>/gi)];
assert.ok(inlineScripts.length > 0, "No inline JavaScript found");
for (const [, source] of inlineScripts) {
  new vm.Script(source, { filename: "dist/index.html" });
}

function parseCornet(text) {
  const parsed = [];
  for (const rawLine of text.replace(/^\uFEFF/, "").split(/\r?\n/)) {
    const line = rawLine.trim();
    if (!line || /^P\d+/i.test(line) || /^RF/i.test(line)) continue;
    const parts = line.split(/[;,\t]/).map((part) => part.trim());
    const value = Number(parts[0]);
    const frequency = Number(parts[1]);
    if (Number.isFinite(value) && Number.isFinite(frequency) && frequency > 0) {
      parsed.push({ value, frequency });
    }
  }
  return parsed.reverse();
}

const sample = parseCornet(fs.readFileSync(samplePath, "utf8"));
assert.equal(sample.length, 5, "The example should contain five valid readings");
const peak = sample.reduce((best, item) => item.value > best.value ? item : best);
assert.deepEqual(peak, { value: 246.5, frequency: 3504 });
const average = sample.reduce((sum, item) => sum + item.value, 0) / sample.length;
assert.ok(Math.abs(average - 53.9738) < 1e-9, "Unexpected example average");

const requiredDocs = [
  "INSTALLATION.md",
  "RECORDING-GUIDE.md",
  "EXPORT-AND-DASHBOARD.md",
  "TROUBLESHOOTING.md",
  "SOFTWARE.md",
  "HOSTING.md"
];
for (const document of requiredDocs) {
  assert.ok(fs.existsSync(path.join(root, "docs", document)), `Missing documentation: ${document}`);
}

console.log("Project validation passed: dashboard syntax, required UI, sample data and documentation.");
