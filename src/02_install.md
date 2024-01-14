## 変換してみる


早速Pandocを使ってマークダウンで書かれたファイルをEPUBに変換してみましょう。

以下の二つのファイルを同じフォルダ内に作ってください。sample.mdはマークダウンによる原稿ファイル、crossref.yamlはpandoc-crossrefの制御ファイルです。いずれのファイルも、文字コードがUTF-8でなければなりません。

リスト1: sample.md
```
#最初の章{#sec:the1st}

「[@sec:the1st]」を参照する。
```

リスト2: crossref.yaml
```yaml
# 全体パラメータ
# 参照に参照先へのリンクを付ける。
linkReferences: true

# セクション用パラメータ
# true:章番号を付ける
numberSections: true  
# 章とみなされる見出しレベル。1なら「#xxx」が章である。
chaptersDepth: 1
# 章番号からいくつの見出しレベルに付番するかを指定する。2なら章と節に付番される。
sectionsDepth: 2
```

コマンドプロンプト（いわゆるDOS窓）を起動し、これらのファイルがあるフォルダに移動してから、下記のコマンドラインを入力して実行してください。

```
pandoc sample.md  \
  -s  \
  --filter pandoc-crossref  \
  --metadata title="Title in command line option"  \
  --metadata crossrefYaml=crossref.yaml  \
  --epub-title-page=false  \
  -o result.epub
```

あっという間に変換が終わります。でき上がったresult.epubをダブルクリックすると、KindlePreviewerで表示されます。


Kindle Previewer の 表示

