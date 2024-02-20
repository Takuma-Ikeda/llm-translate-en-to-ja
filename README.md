# llm-translator

[llm](https://github.com/simonw/llm) の ChatGPT API を使って「英語→日本語」or「日本語→英語」翻訳するスクリプト

## 使い方

1. `./data` ディレクトリに翻訳したい言語が書かれた `target.txt` を格納する
1. スクリプト実行
   - 英語から日本語: `./run_e2j.sh` 実行
   - 日本語から英語: `./run_j2e.sh` 実行
1. `./data` ディレクトリに翻訳ファイル `result.txt` が出力される
1. Mac のクリップボードに翻訳内容がコピーされる
