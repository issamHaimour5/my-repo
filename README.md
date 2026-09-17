# U5DT Token Project

هذا المستودع يحتوي على كود العقد الذكي الخاص بمشروع U5DT، إلى جانب ملف قائمة الرموز (token list) وربط الشعار.

## معلومات المشروع

- الاسم: U5DT Token
- الرمز: U5DT
- عدد الكسور العشرية: 6
- عنوان العقد: TLpYaPQKy7xoGTF91JaAkZahrsdKbr1dTW
- عنوان المحفظة لاستلام الأموال: TKGJHjzZpcyy7ioSfjaQbw3cpm9qpTRRgy
- رابط الشعار: https://raw.githubusercontent.com/issamHaimour5/my-repo/main/assets/logos/TMZVjzgR1hqaB16whL5Lo2JoGYGQf6epNX.png

## هيكل المشروع

- contracts/U5DT.sol
- lists/my-custom-tokenlist.json
- assets/logos/TMZVjzgR1hqaB16whL5Lo2JoGYGQf6epNX.png

## ملف العقد

المصدر الرئيسي للعقد الذكي موجود في:

- contracts/U5DT.sol

## ملف قائمة الرموز

ملف قائمة الرموز موجود في:

- lists/my-custom-tokenlist.json

رابط الملف المباشر:

- https://raw.githubusercontent.com/issamHaimour5/my-repo/main/lists/my-custom-tokenlist.json

## محتوى ملف token list

```json
{
  "name": "My Custom Token List",
  "logoURI": "https://raw.githubusercontent.com/issamHaimour5/my-repo/main/assets/logos/TMZVjzgR1hqaB16whL5Lo2JoGYGQf6epNX.png",
  "timestamp": 1723550000000,
  "version": {
    "major": 1,
    "minor": 0,
    "patch": 0
  },
  "tokens": [
    {
      "chainId": 1000,
      "address": "TLpYaPQKy7xoGTF91JaAkZahrsdKbr1dTW",
      "name": "U5DT Token",
      "symbol": "U5DT",
      "decimals": 6,
      "logoURI": "https://raw.githubusercontent.com/issamHaimour5/my-repo/main/assets/logos/TMZVjzgR1hqaB16whL5Lo2JoGYGQf6epNX.png"
    }
  ]
}
```

## ملاحظات مهمة

- هذا المستودع يحفظ كود العقد ومعلومات الرمز فقط.
- لا يعني أن العقد تم نشره فعليًا على شبكة TRON.
- لا يعني أن العقد تم توثيقه أو اعتماده في TRONSCAN.
- يجب عدم الخلط بين عنوان العقد (Contract Address) وعنوان المحفظة (Wallet Address).
- لا ترسل أي مفتاح خاص أو عبارة استرداد أو كلمة مرور للمحفظة لأي جهة.
- لا تستخدم عنوان المحفظة في خانة Contract Address.

## الفرق بين Contract Address و Wallet Address

- Contract Address: عنوان العقد الذكي الخاص بالرمز.
  مثال: TLpYaPQKy7xoGTF91JaAkZahrsdKbr1dTW

- Wallet Address: عنوان المحفظة الذي يتم استخدامه لاستلام الأموال.
  مثال: TKGJHjzZpcyy7ioSfjaQbw3cpm9qpTRRgy

## كيفية إضافة الرمز في TronLink

1. افتح TronLink.
2. اذهب إلى قسم Assets.
3. اختر Add Token أو Custom Token.
4. ضع هذا العنوان في Contract Address:
   TLpYaPQKy7xoGTF91JaAkZahrsdKbr1dTW
5. تأكد من أن اسم الرمز ورمزه وعدد الكسور العشرية يظهر كما هو.
6. أضف الرمز.
7. لا تستخدم المحفظة كعنوان عقد.

## خطوات النشر الفعلي على شبكة TRON

1. تأكد من وجود رصيد كافٍ من TRX في محفظة TRON.
2. استخدم TronIDE أو Remix أو أي أداة نشر TRON مناسبة.
3. قم بتحميل ملف contracts/U5DT.sol.
4. قم بالتجميع (Compile) باستخدام Solidity 0.8.20.
5. اختر شبكة TRON Mainnet.
6. قم بنشر العقد.
7. احفظ عنوان العقد الذي تم إنشاؤه.
8. افتح TRONSCAN.
9. ابحث عن العنوان الجديد.
10. اختر Verify & Publish.
11. قم بإدخال نفس الكود المصدر كما هو في الملف.
12. تأكد من أن نسخة المترجم مطابقة للنسخة المستخدمة أثناء النشر.
13. أرسل التحقق وانتظر اكتمال التوثيق.

## ملاحظة أخيرة

هذا المشروع تم تجهيزه كقاعدة أولية للإدارة، وتخزين الكود، وتوفير بيانات الرمز في مستودع GitHub. لن يتم اعتبار العقد منشورًا أو موثقًا إلا بعد تنفيذ النشر الحقيقي في شبكة TRON وتأكيد التوثيق عبر TRONSCAN.

## روابط مفيدة

- مستودع المشروع: https://github.com/issamHaimour5/my-repo
- ملف العقد: https://raw.githubusercontent.com/issamHaimour5/my-repo/main/contracts/U5DT.sol
- ملف token list: https://raw.githubusercontent.com/issamHaimour5/my-repo/main/lists/my-custom-tokenlist.json
- TRONSCAN: https://tronscan.org
