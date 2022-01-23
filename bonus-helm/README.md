# Bônus 3 - Helm

## Execução

1. `helm install web ./rotten-potatoes/`

## Helm

Em cada microserviço pode ter uns 10 yaml pra fazer deploy da aplicação, tem que lidar com vários manifestos e atualizar cada um. Tudo isso aumenta muito a complexidade. A forma de resolver esse problema é usando o helm, ele facilita o processo de entrega da aplicação. Facilita o gerenciamento de varios yaml para configurar um deploy, é capaz de gerenciar versões, fazer rollback em versões.

## O que são cada arquivo?

- Chart: templates de manifesto do Kubernetes, em que faz a combinacoes de values com os templates e isso vai gerar o manifesto de instalacao
- Chart.yaml: dados do chart
- Values.yaml: valores que sao juntados aos templates
- Templates: a estrutura que será combinada com os values pra gerar o setup final
- Arquivos tpl: quando quiser padronizar valores ou templates pra ser mais generico
- NOTES.txt: onde ficam os comunicados
- .helmignore: como se fosse um .gitignore ou .dockerignore

A combinação dos values com os templates geram um output que vai ser aplicado no cluster kubernetes

## Comandos

- `helm create <nome-projeto>`: iniciar o projeto helm
   - `helm create rotten-potatoes`
- `helm install web ./rotten-potatoes --debug --dry-run`: ver o resultado sem executar no cluster kubernetes
- `helm install web ./rotten-potatoes`
- `helm list`: lista td que esta rodando no cluster utilizando helm
- `helm upgrade web ./rotten-potatoes`: não precisa deletar os objetos do kubernetes e criar de novo, só atualiza a release dos objetos que já estão rodando
- `helm upgrade web ./rotten-potatoes --values=./rotten-potatoes/release-values.yaml`: sobreescreve alguns parametros do "values.yaml" padrao com um customizado "release-values.yaml"
- `helm history web`: mostra todas as instalacoes feitas
- `helm rollback <nome-release> <numero-revision>`: mostra todas as instalacoes feitas
   - `helm rollback web 3`
- `helm uninstall web`: desinstalar a aplicação no cluster kubernetes
