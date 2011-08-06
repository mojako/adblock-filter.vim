adblock-filter.vim
==================

Vim syntax file for Adblock Plus filter

練習作なので、不具合があるかもしれません。修正歓迎。

Requirements / 必要環境
-----------------------

* openssl (for auto checksum, 自動チェックサムに必要)

Auto Checksum / 自動チェックサム
--------------------------------

Update `Checksum:` comments when writing changes.

By default, auto checksum is disabled. To enable auto checksum,
add this to your `~/.vimrc`:

```
let g:adblock_filter_auto_checksum = 1
```

-----

保存時に、`Checksum:` を含むコメント行を更新します。

この機能は、デフォルトでは無効です。有効にするには、`~/.vimrc` などに
以下の行を追加してくだい。

```
let g:adblock_filter_auto_checksum = 1
```
