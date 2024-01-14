# 基本的な使い方


本章では、図を例にとり、付番や参照の書き方などの基本的な事柄を説明します。  

## 図への付番と参照

### 図への付番

図に番号を与えるには、以下のように書きます。

```
![caption](imageResourceUrl "imageTitle"){#fig:id} 
```

この書き方の前半部分である「`![caption](imageResourceUrl "imageTitle")`」は、Markdownの書き方そのものです。
`imageTitle`を省略してかまいません。`caption`を省略すると、図タイトルが表示されなくなるだけではなく、参照もできなくなります。

付番にかかわるのはその後ろに付け足された`{#fig:id}`です。

* 前半部分とこの部分は、空白で区切られていてはなりません。
* `#fig:` は、画像に付番するよう指示する部分で、常にこの通りに書かなければなりません。
* `id` は、この画像を識別するための任意の一語とみなせる文字列であり、文書中でユニークでなければなりません。
* `id` は、日本語でもかまいません。

`{#fig:id}` が付けられていない場合、つまり、Markdownのイメージ貼り付けそのままの場合、番号が付けられず、参照もできません。

### 図の参照

図を参照するには、以下のように書きます。

```
[@fig:id]
```

`id` には、画像に付けられたidを指定してください。

### 例

例としてmonument.jpgという画像ファイルを文書に取り込んで付番し参照する例を掲げます。


リスト3: sample.md
```
![図のキャプション](monument.jpg){#fig:monumentId}

図の参照：「[@fig:monumentId]」
```

`Crossref.yaml` は、前章のものをそのまま使ってください。コマンドラインも同じです。

このMarkdownは、monument.jpgというファイルを取り込んでmonumentIdというIDを与え、その次の行でそれを参照しています。
変換して下図のように表示されれば成功です。

ab図1:画像への付番の例.a—図の表示,b—参照の表示

表示が2ページに分かれているのは、Kindleの仕様によります。

## Pandoc制御ファイル

ここまで使ってきたPandocのコマンドラインは、長くて書くのが大変です。
バッチファイルなどのスクリプトを作る手もありますが、それより見てわかりやすい制御ファイルを作りましょう。

リスト 4に制御ファイルの例を掲げます。  
ここまで使ってきたコマンドラインのオプションを設定するものです。このファイルの文字コードもUTF-8でなければなりません。

リスト4: pandoc.yaml
```yaml
#コマンドラインは、「pandoc -d pandoc.yaml」です。

input-files:  # 入力ファイルは、sample.mdです。
    - sample.md
output-file: result.epub  # 出力ファイルは、result.epubです。
standalone: true  # 出力を単体で表示できるようにします。
filters:
    - pandoc-crossref  # pandoc-crossrefを使います。
metadata:
    crossrefYaml: "Crossref.yaml"  # pandoc-crossrefの制御ファイルです。
    title: "Title in command line option"  # ドキュメントタイトルです。
    number-sections: false  # Pandocにセクション番号を付けさせません。
```

このファイルを利用したコマンドラインは、以下のようにとてもシンプルになります。

```
$ pandoc -d pandoc.yaml
```

`-d` オプションによりPandocに制御ファイル名を知らせています。  
Pandocは、このファイルの内容をコマンドラインオプションの代わりに取り込んでMarkdownファイルを変換します。  

コマンドラインオプションを指定することにより、制御ファイルによる指定をオーバーライドすることもできます。  
例えば、制御ファイルで指定されているEPUBファイルではなくHTMLファイルに変換させるには、以下のようなコマンドラインを使います。太字部分で指定した出力ファイル名が制御ファイルで指定されているものをオーバーライドして、`result.html`というファイルを出力します。

```
$ pandoc -d Pandoc.yaml -o result.html
```

これをブラウザで表示すると、図2のようになります。

HTMLファイルの方がEPUBより表示にかかる時間が短いので、執筆中には、変換結果をすばやく確認するためにHTMLファイルを作るようお勧めします。  
KDPで出版するならば、もちろん、最終的にはEPUBを作っての確認が必要です。