# התקנה וזיהוי הדרייבר

## 1. ציוד

- Cornet ED88TPlus או ED98QPro5G עם יכולת Data Logging
- כבל Micro‑USB **שתומך Data**, לא כבל טעינה בלבד
- מחשב Windows
- מקור מתח שיכול להחזיק את המכשיר לכל משך המדידה, לפי הוראות היצרן

הדלקה של ה־Cornet בעת חיבור USB מוכיחה שהכבל מעביר מתח, אבל לא בהכרח שהוא מעביר נתונים.

## 2. זיהוי השבב לפני התקנה

1. פתח `Device Manager`.
2. הרחב `Ports (COM & LPT)`.
3. חבר את ה־Cornet והשווה מה נוסף לרשימה.
4. רשום את שם ההתקן ואת מספר ה־COM. המספר יכול להשתנות בין שקעי USB.

בחר דרייבר לפי השם שמופיע בפועל:

| מה מופיע ב־Device Manager | דרייבר |
|---|---|
| `USB-SERIAL CH340` או CH341 | WCH CH340/CH341 |
| `Holtek USB to UART Bridge` | Holtek USB Bridge, בחירה `USB to UART Bridge` |
| התקן FTDI | FTDI VCP/CDM |

אל תתקין `CDM21228` רק מפני שהשם הופיע במדריך ישן; זו חבילת FTDI והיא אינה הדרייבר של CH340 או Holtek.

במחשב שנבדק עבור הפרויקט, ה־Cornet הופיע כ־`USB-SERIAL CH340 (COM6)` והותקן `CH341SER`, גרסה `4.0.2026.2`. מספר ה־COM אינו קבוע ואינו חלק מהדגם.

## 3. התקנת CH340/CH341

1. הורד מהעמוד הרשמי של WCH: [CH341SER.EXE](https://www.wch.cn/downloads/CH341SER_EXE.html).
2. אמת שהמפרסם והחתימה תקינים בחלון Properties של הקובץ.
3. התקן וחבר מחדש את ה־Cornet.
4. ודא שאין סימן אזהרה צהוב ב־Device Manager.

## 4. התקנת Holtek, רק אם זה ההתקן שזוהה

בחבילת Amir שנבדקה שם הקובץ הוא `USBBridgeSetup_CA.zip`. בתוך המתקין יש לבחור:

```text
USB to UART Bridge
```

לא לבחור SPI ולא IIC. מאחר שמדובר בחבילה ישנה, Windows עשוי להציג אזהרת תאימות או חתימה. אין לעקוף אזהרה בלי לוודא שהקובץ הגיע מהמקור הצפוי.

SHA‑256 של החבילה שנבדקה ב־03.11.2026:

```text
44C014344DA27020EB60BA5240ED31EAE9C8825B290A17BE1CA4331428725D5A
```

ה־ZIP והמתקינים עצמם אינם נשמרים בריפו: הם קבצים של צד שלישי ועלולים להתיישן.

## 5. התקנת Tera Term

1. הורד רק מ־[עמוד הגרסאות הרשמי](https://github.com/TeraTermProject/teraterm/releases).
2. התקן את גרסת x64 המתאימה למחשב.
3. הפעל את Tera Term ובחר `Serial`, לא TCP/IP.

הגרסה שנבדקה מקומית היא Tera Term 5.7.1 x64. SHA‑256 של המתקין הרשמי שנבדק:

```text
A091233B41AD3EBD2277892AD9EF077148F1720171AE225C041E895E573343FE
```

אפשר לוודא את סביבת Windows בלי לשנות דבר:

```powershell
powershell -ExecutionPolicy Bypass -File tools/check-windows-setup.ps1
```

## 6. בדיקת תקשורת ראשונה

1. סגור כל תוכנה אחרת שעלולה להחזיק את יציאת ה־COM.
2. פתח Tera Term ובחר את ה־COM שהופיע ב־Device Manager.
3. בחר `Setup > Serial port` והגדר:

```text
Speed:        9600
Data:         8 bit
Parity:       none
Stop bits:    1 bit
Flow control: none
```

4. אשר. אין צורך שהמכשיר ישדר כל הזמן; הנתונים יופיעו לאחר `Send data` בתפריט ה־Logger שלו.

המשך: [הקלטה עצמאית ל־24 שעות](RECORDING-GUIDE.md).
