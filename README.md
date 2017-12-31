# nhkculture

NHKラジオ第二「NHKカルチャーラジオ・文学の世界」録音スクリプト

## 必要要件

- Windows Vista以降（PowerShellがインストールされていること）（Win7でしかテストしていません）
- VLC Media Player

## 使い方

VLCメディアプレーヤーがインストールされていることが前提。

nhkculture.ps1 ファイルをメモ帳などのテキストエディタで開き、

```
$vlcexe = 'C:\Program Files\VideoLAN\VLC\vlc.exe'
```

この部分を、自分の環境に書き換える。64bitOSでCにVLCをインストールしていれば、このままでOKだと思う。

同様に、

```
$destdir = 'E:\music\nhk-bungei\'
```

の部分を、音声ファイルを保存したいディレクトリ名に変える。あらかじめフォルダを作っておく。

nhkculture.bat ファイルをダブルクリックすると、次の「文学の世界」の録音が予約される。

nhkculture.bat ファイルのショートカットを、スタートアップフォルダに入れておくと、PC起動時に予約される。

「スタートアップフォルダ」は、`Windows`キーを押しながら`R`を押し、「名前」に`shell:startup`と入力して`Enter`で開くことができる。

## 現時点で

録音が始まると、「デコーダーがうんたらかんたら」のようなエラーメッセージが出るが、いちおう録音はできる。

