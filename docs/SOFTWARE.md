# תוכנות, מקורות וגרסאות

## רכיבים מומלצים

| רכיב | שימוש | מקור |
|---|---|---|
| Tera Term | לכידת פלט Serial לקובץ | [האתר הרשמי](https://teratermproject.github.io/index-en/) / [GitHub Releases](https://github.com/TeraTermProject/teraterm/releases) |
| WCH CH341SER | דרייבר ל־CH340/CH341 | [WCH הרשמי](https://www.wch.cn/downloads/CH341SER_EXE.html) |
| Holtek USB Bridge | רק להתקן שמזדהה כ־Holtek | חבילת היצרן/המפיץ שנמסרה עם המכשיר |
| הדשבורד בפרויקט | ניתוח מקומי של CSV/TXT | `dist/index.html` |

## מה לא נדרש

- TeraBox — שירות אחסון ענן שאינו קשור לתקשורת Serial.
- EnviroSens Monitoring לצורך ייצוא FlashMem — אפשר להשתמש ב־Tera Term, שהוא פשוט ושקוף יותר. להקלטת Realtime, EnviroSens עבדה אצלנו על COM6 לאחר הגדרת `Logg time = 0.5 sec` ו־`Data2Send = RealTime`; היא אינה מזהה נכון את המד כשהוא מציג `NoRealtime` במרווח 1 ms.
- FTDI CDM21228 — אלא אם Device Manager מזהה בפועל שבב FTDI.

## גרסאות שאומתו במחשב הבדיקה

- Tera Term 5.7.1 x64
- WCH CH341SER 4.0.2026.2
- Holtek USB Bridge Installer מחבילת Amir

## Checksums

```text
Tera Term 5.7.1 x64 installer
SHA-256 A091233B41AD3EBD2277892AD9EF077148F1720171AE225C041E895E573343FE

USBBridgeSetup_CA.zip from Amir
SHA-256 44C014344DA27020EB60BA5240ED31EAE9C8825B290A17BE1CA4331428725D5A

Monitoring_Cornet.zip from Amir
SHA-256 9AFD961BFF8BC6E561E77E84F10B7239D81A82A39DF9358F0F20D2C1DEA985BE
```

Checksum מאמת שהקובץ זהה לקובץ שנבדק; הוא אינו מוכיח בפני עצמו שהקובץ בטוח או עדכני.

## מקורות להליך

- [Cornet ED88TPlus Data Logging](https://www.maxicom.se/res/Textfiler/ED88TPlus-Data-Logging.pdf): מבנה ה־Logger, כ־1,000 נקודות, מרווחים, FlashMem והגדרות 9600 8‑N‑1.
- [Tera Term documentation](https://teratermproject.github.io/manual/5/en/): הגדרות Serial ולכידה לקובץ.
- [עמיר בורנשטיין — רמות חשיפה לקרינת רדיו](https://www.norad4u.co.il/emr-measurement-h/emf-standards-h/rf-standards/): טבלת הייחוס המוצגת בדשבורד.

## מדיניות קבצים בינאריים

מתקינים, ZIP וקובצי מדידה אישיים אינם נשמרים בריפו. כך נמנעים מהפצת תוכנה של צד שלישי, מקבצים מיושנים ומדליפת נתוני מיקום/שינה. הריפו שומר מקורות רשמיים, גרסאות ו־SHA‑256 לצורך אימות.
