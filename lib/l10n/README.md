# Hướng dẫn cập nhật file l10n
1. Thêm bộ ngôn ngữ mới có định dạng: app_code.arb
2. Thêm code ngôn ngữ mới vào supportedLocales trong MaterialApp
3. Chạy lệnh sau để cập nhật lại.
``````
 flutter gen-l10n
``````