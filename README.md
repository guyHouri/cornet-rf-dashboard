# Cornet RF Night Logger

מדריך מלא למדידת RF ממושכת עם Cornet ED88TPlus/ED98QPro5G, שמירת המדידות בזיכרון המכשיר, ייצוא למחשב באמצעות Tera Term והצגה בדשבורד מקומי.

הדשבורד החי: [cornet-rf.167-233-222-219.sslip.io](https://cornet-rf.167-233-222-219.sslip.io/)

הקובץ שנבחר בדשבורד מעובד בדפדפן ואינו נשלח לשרת.

## התהליך בקיצור

1. מזהים ב־Device Manager איזה שבב USB מופיע ומתקינים **רק** את הדרייבר המתאים.
2. מתקינים את **Tera Term** הרשמי. אין צורך ב־TeraBox.
3. ב־Cornet מגדירים `Logg time` של 2 דקות, מנקים מדידות ישנות ומתחילים סשן חדש כשהמכשיר מנותק מהמחשב.
4. בסוף הסשן שומרים את הבאפר ל־`FlashMem` לפני כיבוי.
5. מחברים למחשב, פותחים Tera Term על יציאת ה־COM הנכונה ב־`9600, 8-N-1, Flow control: none`, מפעילים לכידה לקובץ ובוחרים במכשיר `Data2Send = FlashMem` ואז `Send data`.
6. טוענים את קובץ ה־CSV/TXT לדשבורד.

## מדריכים

- [התקנה וזיהוי הדרייבר](docs/INSTALLATION.md)
- [הקלטה עצמאית ל־24 שעות](docs/RECORDING-GUIDE.md)
- [קיבולת הזיכרון ובחירת מרווח דגימה](docs/CAPACITY-AND-INTERVALS.md)
- [ייצוא עם Tera Term וטעינה לדשבורד](docs/EXPORT-AND-DASHBOARD.md)
- [פתרון תקלות](docs/TROUBLESHOOTING.md)
- [תוכנות, מקורות וגרסאות](docs/SOFTWARE.md)
- [פריסה ואחסון](docs/HOSTING.md)

## מה הדשבורד מציג

- שיא RF וממוצע חשבוני של כל הקריאות התקינות
- תדר הקריאה הגבוהה ביותר וסימון התאמה לתחומי 5G מובהקים בישראל
- גרף כרונולוגי בסולם לוגריתמי
- תאריך ושעה מחושבים לכל מדידה לפי שעת התחלה ומרווח שהמשתמש מזין
- מספר דגימות ומשך משוער לפי מרווח הדגימה
- טבלת הייחוס של עמיר בורנשטיין, עם ייחוס והסתייגות כפי שמופיעים בעמוד
- הורדת CSV מנוקה

התדר לבדו אינו יכול להוכיח שטכנולוגיית השידור היא 5G בתחומים שמשותפים גם לטכנולוגיות אחרות. לכן הדשבורד מסמן כ־5G רק את התחומים המובהקים שהוגדרו בו, ולא מסיק 5G אוטומטית מ־700 MHz או 2.6 GHz.

## מגבלות שחשוב לדעת

- ייצוא `FlashMem` אינו מכיל חותמת זמן מלאה לכל שורה. יש לרשום בנפרד את שעת ההתחלה ושעת הסיום.
- לפי מדריך Cornet, ה־FlashMem נשלח מהקריאה החדשה לישנה. הדשבורד הופך את הסדר לתצוגה כרונולוגית.
- כל דגימה היא המקסימום שנמדד בתוך חלון הזמן, לא ממוצע של החלון.
- ב־ED98QPro5G יש 1,024 נקודות ב־Buffer ועוד 1,024 ב־FlashMem, אך ה־Flash הוא צילום נפרד ואינו מרחיב אוטומטית סשן ללא השגחה. לתכנון סשן רציף משתמשים ב־1,024 נקודות.
- במרווח 2 דקות, 1,024 נקודות מכסות 34 שעות ו־8 דקות; 24 שעות צורכות 720 נקודות.
- זו תצוגת נתוני מכשיר, לא קביעה רפואית ולא מדידת מעבדה מכוילת.

## מבנה הפרויקט

```text
dist/index.html                  הדשבורד הסטטי
docs/                           מדריכי התקנה, הקלטה, ייצוא ותקלות
data/example-flash.csv          קובץ בדיקה לדשבורד
data/session-metadata.example.json  תבנית לרישום זמני סשן
tools/check-windows-setup.ps1   בדיקה לקריאה בלבד של Tera Term, COM ודרייברים
tools/validate-project.mjs      בדיקות תקינות בסיסיות
```

## הרצה ובדיקה מקומית

אפשר לפתוח את `dist/index.html` ישירות, או להגיש את התיקייה עם שרת סטטי. לבדיקת הפרויקט:

```powershell
node tools/validate-project.mjs
powershell -ExecutionPolicy Bypass -File tools/check-windows-setup.ps1
```

## מקורות מרכזיים

- [מדריך Data Logging של Cornet ED88TPlus](https://www.maxicom.se/res/Textfiler/ED88TPlus-Data-Logging.pdf)
- [מדריך Data Logging הרשמי של Cornet ED98QPro5G v2.0](https://electrosmog.org/resources/ED98QPro5G%20Data%20Logging-v2.0.pdf)
- [Tera Term — האתר הרשמי](https://teratermproject.github.io/index-en/)
- [Tera Term — גרסאות רשמיות ב־GitHub](https://github.com/TeraTermProject/teraterm/releases)
- [WCH — דרייבר CH340/CH341 הרשמי](https://www.wch.cn/downloads/CH341SER_EXE.html)
- [עמיר בורנשטיין — רמות חשיפה לקרינת רדיו](https://www.norad4u.co.il/emr-measurement-h/emf-standards-h/rf-standards/)

## פרטיות

קובצי מדידה אישיים אינם אמורים להיכנס ל־Git. התיקיות `captures/`, `data/incoming/` ו־`data/private/` מוחרגות באמצעות `.gitignore`.
