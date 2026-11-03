# פתרון תקלות

## המכשיר נדלק, אבל אין יציאת COM

הכבל עשוי להיות כבל טעינה בלבד. נסה כבל Micro‑USB שמוצהר עליו Data, שקע USB אחר, ובדוק שוב את Device Manager. הדלקה מוכיחה מתח בלבד.

## מופיע Unknown device או סימן אזהרה

פתח את Properties של ההתקן ובדוק `Hardware Ids`. התקן דרייבר לפי השבב המזוהה:

- CH340/CH341 → WCH CH341SER
- Holtek → USB to UART Bridge
- FTDI → FTDI VCP/CDM

אל תתקין את שלושתם כפתרון ניסוי אקראי.

## COM5 או COM1 “does not exist”

המספר שמור בהגדרה ישנה. חבר את המכשיר, מצא את ה־COM הנוכחי ב־Device Manager ובחר אותו ב־Tera Term. מספר ה־COM יכול להשתנות.

## Access denied / Cannot open COM

סגור את Monitoring, חלונות Tera Term אחרים ותוכנות Serial. נתק וחבר מחדש. יציאת COM ננעלת בדרך כלל בידי תוכנה אחת בכל פעם.

## Tera Term פתוח, אבל לא מופיע כלום

- ודא שבחרת Serial ולא TCP/IP.
- ודא 9600, 8 data bits, no parity, 1 stop bit, no flow control.
- הפעל `File > Log`.
- במכשיר בחר `Data2Send = FlashMem` ואז `Send data`.

Tera Term אינו אמור להציג נתונים לפני שה־Cornet שולח אותם.

## קיבלתי רק נתונים חיים

`Data2Send` כנראה מוגדר `RealTime`. שנה ל־`FlashMem`, ואם קיימת האפשרות בצע קודם `Read from FlashMem`, ואז `Send data`.

## הקובץ ריק

ייתכן שהלוג הופעל אחרי השליחה, או שהבאפר לא נשמר ל־FlashMem לפני הכיבוי. הפעל `File > Log` לפני `Send data` וחכה לסיום לפני סגירת הקובץ.

## יש הרבה שורות עם תדר 0000

אלה תאים ריקים/סמנים מתוך dump של הזיכרון. הדשבורד מסנן שורות שבהן אין תדר תקין.

## אין שעות ליד הקריאות

זה צפוי: ייצוא FlashMem כולל סדר ומרווח, לא שעה מוחלטת לכל נקודה. רשום את זמן ההתחלה והסיום בנפרד. הדשבורד מציג זמן יחסי לפי המרווח.

## Clear buffer ואז Save to FlashMem?

רק בתחילת סשן חדש: `Clear buffer`, הגדרת המרווח ו־`Save config`. בסוף הסשן: `Save to FlashMem`. ניקוי הבאפר בסוף, לפני השמירה ל־FlashMem, עלול למחוק את המדידות שרצית לשמור.

## התוכנה מזהה מכשיר גם כשהכול מנותק

אל תסתמך על הכיתוב בלבד. אמת באמצעות Device Manager: נתק וחבר וצפה באיזה התקן נעלם וחוזר. תוכנת Monitoring הישנה עשויה להציג COM או דגם מהגדרה שמורה.

## בדיקה אוטומטית לקריאה בלבד

מתיקיית הפרויקט הרץ:

```powershell
powershell -ExecutionPolicy Bypass -File tools/check-windows-setup.ps1
```

הסקריפט אינו מתקין או מסיר דבר. הוא רק מציג יציאות COM, דרייברים רלוונטיים ומיקום Tera Term.
