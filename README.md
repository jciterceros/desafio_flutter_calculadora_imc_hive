# Desafio Flutter Calculadora IMC com Hive

Este é um projeto Flutter que implementa uma calculadora de IMC (Índice de Massa Corporal) com persistência de dados utilizando o Hive.

## Funcionalidades

- Cálculo do IMC com base no peso e altura fornecidos pelo usuário.
- Classificação do IMC de acordo com os padrões de saúde.
- Persistência de dados utilizando o Hive.
- Exibição de uma tabela com os resultados e classificações.
- Interface amigável e responsiva.

## Estrutura do Projeto

- **lib/main.dart**: Arquivo principal que inicializa o Hive e executa o aplicativo.
- **lib/pages/home_page.dart**: Página inicial onde o usuário insere os dados e calcula o IMC.
- **lib/pages/result_page.dart**: Página que exibe os resultados salvos e suas classificações.
- **lib/controllers/pessoa_controller.dart**: Controlador responsável pela lógica de cálculo e validação.
- **lib/database/pessoa_model.dart**: Modelo de dados utilizado para persistência no Hive.
- **lib/services/classificacao_service.dart**: Serviço que classifica o IMC com base nos valores calculados.

### Estrutura de Pastas

```plaintext
lib/
├── controllers/
│   └── pessoa_controller.dart    # Controlador responsável pela lógica de cálculo e validação.
├── database/
│   └── pessoa_model.dart         # Modelo de dados utilizado para persistência no Hive.
├── models/
│   └── pessoa.dart               # Modelo de dados para a pessoa, incluindo nome, peso e altura.
├── pages/
│   ├── home_page.dart            # Página inicial onde o usuário insere os dados e calcula o IMC.
│   └── result_page.dart          # Página que exibe os resultados salvos e suas classificações.
├── services/
│   └── classificacao_service.dart # Serviço que classifica o IMC com base nos valores calculados.
├── app_widget.dart               # Configuração principal do aplicativo.
└── main.dart                     # Arquivo principal que inicializa o Hive e executa o aplicativo.
```

### Dependências Utilizadas
- **flutter**: Framework principal para desenvolvimento.
- **hive**: Banco de dados local para persistência de dados.
- **hive_flutter**: Integração do Hive com o Flutter.

### Pré-requisitos
- Flutter SDK (versão mínima: 3.0.0)
- Dart SDK
- Editor de código como Visual Studio Code ou Android Studio

### Tecnologias Utilizadas
- Flutter
- Hive (banco de dados local)
- Dart
- Material Design (UI)

### Estrutura de Dados
O modelo de dados PessoaModel é utilizado para armazenar as informações de cada pessoa, incluindo:
- Nome
- Peso
- Altura
- IMC (calculado dinamicamente)

### Melhorias Futuras
- **Testes Unitários**: Implementar testes para validar a lógica de cálculo do IMC e a persistência de dados no Hive.
- **Interface do Usuário**: Adicionar animações para melhorar a experiência do usuário.
- **Suporte a Idiomas**: Implementar internacionalização (i18n) para suportar múltiplos idiomas.
- **Exportação de Dados**: Permitir exportar os resultados em formatos como CSV ou PDF.


### Exemplo de Uso
1. Insira seu nome, peso e altura na tela inicial.
2. Clique no botão "Calcular IMC".
3. Veja o resultado do IMC e sua classificação na tabela de resultados.

### Contribuição
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

### Licença
Este projeto está licenciado sob a licença MIT. Consulte o arquivo LICENSE para mais detalhes.

### Como Executar o Projeto

1. Certifique-se de ter o Flutter instalado em sua máquina. Para mais informações, consulte a [documentação oficial do Flutter](https://docs.flutter.dev/).
2. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/desafio_flutter_calculadora_imc_hive.git