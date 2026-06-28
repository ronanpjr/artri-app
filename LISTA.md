Bug encontrado:
Login não funcionava corretamente

Os campos email e password estavam indo para o backend vazios. 
Foi obrigatório corrigir isso antes de continuar os testes porque seria impossível testar o restante da interface sem fazer login.

Logs dos testes: 
``` 
2026-06-27 20:19:12.254  7182-7182  flutter                 com.example.artriapp                 I  ENTRAR button pressed
2026-06-27 20:19:12.254  7182-7182  flutter                 com.example.artriapp                 I  Email: 
2026-06-27 20:19:12.254  7182-7182  flutter                 com.example.artriapp                 I  Password: 
2026-06-27 20:19:13.029  7182-7182  flutter                 com.example.artriapp                 I  Error on user login, FormatException: Unexpected character (at character 1)
2026-06-27 20:19:13.029  7182-7182  flutter                 com.example.artriapp                 I  <!DOCTYPE html>
2026-06-27 20:19:13.029  7182-7182  flutter                 com.example.artriapp                 I  ^
2026-06-27 20:19:13.029  7182-7182  flutter                 com.example.artriapp                 I  
2026-06-27 20:19:34.431  7182-7182  ImeTracker              com.example.artriapp                 I  com.example.artriapp:65d80cc4: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
```

Fixes realizados:
1. InputText: virou StatefulWidget para não apagar o texto ao abrir o teclado.
2. LoginViewModel: adicionado notifyListeners() para a interface reconhecer o que foi digitado.
3. Removidos o espaço e as aspas do .env