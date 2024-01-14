# pandoc template

このリポジトリはpandocのテンプレートです。  
markdownから以下のフォーマットに出力する支援をしてくれます。

* html
* epub
* latex
* pdf

## 基本的な使い方

1. 設定ファイルを更新する。

* 共通：pandoc_config.yaml
* フォーマット固有: ディレクトリconf以下にあるテンプレート名のyamlファイル

2. src配下にmarkdownを記載する。

3. pandoc_build.shを用いてビルドする。  
   例えばepub形式の出力をしたい場合は、以下の通り入力する。

```
$ ./pandoc_build.sh epub
```

4. ディレクトリoutputs以下にビルドされたドキュメントが配置される。

## 環境導入

### はじめに

基本的にOS環境に依存せず稼働するものとは思う。  
ここでは、Ubuntu Server 22.04 LTSをベースに以下を導入する前提で解説を行う。

* pandoc
* pandoc-crossref
* TeX Live YYYY

ただし、上記のYYYYはTeX Liveの最新バージョンとする。  
pandocとpandoc-crossrefはdebファイルではなく、Haskell Tool Stackをもとに導入する。

### ubuntuのライブラリの導入

ライブラリについては [The Haskell Tool Stack - Install or upgrade](https://docs.haskellstack.org/en/stable/install_and_upgrade/)を参考に、後ほど必要なpkg-configを追加している。

```
$ sudo apt update
$ sudo apt install -y g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase pkg-config
```

### Pandoc環境の導入

#### cabalのインストール

```
$ curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

（質問されるので、答えながら進める）

シェルを再起動する。

cabalのバージョンを確認する。

```
$ cabal --version
cabal-install version 3.10.2.1
compiled using version 3.10.2.1 of the Cabal library
```

#### Pandocとpandoc-crossrefのインストール

まずはcabalのupdateを行う。

```
$ cabal update
```

Pandoc本体のインストールを行う。

```
$ cabal install pandoc-cli
```

同様ににpandoc-crossrefのインストールを行う。

```
$ cabal install pandoc-crossref
```

インストールが終わったらターミナルを再起動し、pandocのバージョンを確認する。

```
$ pandoc --version
pandoc 3.1.11.1
Features: +server -lua
Scripting engine: none
User data directory: /home/user01/.local/share/pandoc
Copyright (C) 2006-2023 John MacFarlane. Web: https://pandoc.org
This is free software; see the source for copying conditions. There is no
warranty, not even for merchantability or fitness for a particular purpose.
```

pandoc-crossrefのバージョンも確認する。

```
$ pandoc-crossref --version
pandoc-crossref v0.3.17.0 git commit UNKNOWN (UNKNOWN) built with Pandoc v3.1.11.1, pandoc-types v1.23.1 and GHC 9.4.8
```


### TeX Liveのインストール

Linux 環境へTeX Liveをインストールするには、インストールスクリプトinstall-tlを利用する。  
install-tlはPerl製であることから、前提となるPerlのモジュールをインストールする。

```
$ sudo apt install curl perl-modules
```

インストーラのアーカイブ（install-tl-unx.tar.gz）をダウンロードし、展開する。

```
$ cd /tmp
$ curl -LO https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
$ tar xf install-tl-unx.tar.gz
```

展開したときディレクトリ配下に移動（`yyyymmdd`は作業日付）して、インストーラを実行する。

```
$ cd install-tl-yyyymmdd/
$ sudo ./install-tl
```

「Enter Command:」と尋ねられるので、「I」（インストール開始）と入力し、インストールを開始する。  
トータルで5GB近くのファイルのダウンロードが行われるため、インストールをはじめる際はネットワーク環境にご注意すること。

```
Actions:
<I> start installation to hard disk
<P> save installation profile to 'texlive.profile' and exit
<Q> quit
Enter command:
```

TeX Liveをインストールすると、実行ファイルが/usr/local/texlive/YYYY/bin/x86_64-linux に配置されるため、実行ファイルにパスを通しておきましょう。
（YYYYはインストールしたTeX Liveのバージョン年度）

bash をお使いの場合はホームディレクトリの`.bashrc` の末尾に以下のように書き足します。

```
export PATH=/usr/local/texlive/YYYY/bin/x86_64-linux:$PATH
```

再度ターミナルを起動し、platex コマンドが実行できればインストールは完了となる。

```
$ platex --version
e-upTeX 3.141592653-p4.1.0-u1.29-230214-2.6 (utf8.euc) (TeX Live 2023)
kpathsea version 6.3.5
ptexenc version 1.4.3
Copyright 2023 D.E. Knuth.
There is NO warranty.  Redistribution of this software is
covered by the terms of both the e-upTeX copyright and
the Lesser GNU General Public License.
For more information about these matters, see the file
named COPYING and the e-upTeX source.
Primary author of e-upTeX: Japanese TeX Development Community.
```

