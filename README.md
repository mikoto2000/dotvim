# My Vim Configuration

これは、私の個人的なVim/Neovim設定です。

## 特徴

*   **Vim & Neovim 対応**: `vimrc` と `init.vim` の両方をサポートしています。
*   **プラグイン管理**: Vim 8 の標準パッケージ機能 (`pack`) を利用してプラグインを管理しています。
    *   プラグインは `git submodule` で管理されており、再現性が高いです。
*   **豊富なスニペットとテンプレート**: `snippets/` と `template/` ディレクトリに、様々な言語用のスニペットとテンプレートが用意されています。
*   **LSPサポート**: `vim-lsp` と `vim-lsp-settings` により、モダンな開発体験を提供します。
*   **GitHub Copilot**: `copilot.vim` を導入しています。

## インストール

1.  リポジトリをクローンします。`--recursive` オプションを付けて、サブモジュールも同時にクローンしてください。

    ```bash
    git clone --recursive https://github.com/mikoto2000/dotvim.git ~/.vim
    ```

2.  (Neovimの場合) `~/.config/nvim` にシンボリックリンクを貼ります。

    ```bash
    ln -s ~/.vim ~/.config/nvim
    ```

3.  Vim/Neovim を起動します。

### プラグインの更新

```bash
git pull --rebase
git submodule update --init --recursive
```

## ディレクトリ構成

```
.
├── vimrc, init.vim   # Vim/Neovim のメイン設定ファイル
├── gvimrc              # GVim 用の設定
├── pack/               # Vim 8 パッケージ機能によるプラグイン
│   ├── (group)/
│   │   ├── start/      # 起動時に読み込むプラグイン
│   │   └── opt/        # 遅延読み込みするプラグイン
├── snippets/           # スニペット (tiny-snippet.vim or sonictemplate-vim)
├── template/           # テンプレート (sonictemplate-vim)
└── autoload/           # 自作関数など
```

## キーマッピング

`<Leader>` キーは ` ` (スペース) に設定されています。

### ウィンドウ・タブ・バッファ操作

| キー | ノーマルモード | 説明 |
|:---|:---|:---|
| `<Leader>sp` | `:split` | ウィンドウを水平分割します。 |
| `<Leader>vs` | `:vsplit` | ウィンドウを垂直分割します。 |
| `<Leader>l` | `:call buffer_selector#OpenBufferSelector()` | バッファ一覧を開きます。 |
| `<Leader>bb` | `:b#` | 直前のバッファに切り替えます。 |
| `<Leader>b` | `:buffer ` | 指定したバッファに切り替えます。 |
| `<Leader>e` | `:call file_explorer#OpenFileExplorer(...)` | カレントディレクトリでファイルエクスプローラを開きます。 |
| `<Leader>f` | `:call file_selector#OpenFileSelector()` | ファイルセレクタを開きます。 |
| `<Leader>mru` | `:call oldfiles_selector#OpenOldfilesSelector()` | 最近使ったファイル一覧を開きます。 |

### テキスト編集・操作

| キー | モード | 説明 |
|:---|:---|:---|
| `<Esc><Esc>` | ノーマル | 検索ハイライトを消去します。 |
| `<Leader>fo` | ノーマル | 折りたたみを開きます。 |
| `<Leader>fc` | ノーマル | 折りたたみを閉じます。 |
| `<Leader>=` | ビジュアル | 選択範囲をVim scriptとして評価し、結果で置き換えます。 |
| `p` / `P` | ビジュアル | ビジュアルモードでの `p` と `P` の挙動を入れ替えます。 |
| `<C-@>` | インサート | `<Esc>` と同じくインサートモードを抜けます（誤爆防止）。 |
| `<C-@>` | ノーマル | `:nohlsearch` と同じく検索ハイライトを消去します。 |

### LSP (Language Server Protocol)

| キー | モード | 説明 |
|:---|:---|:---|
| `<F2>` | ノーマル/インサート | シンボルの名前を変更します (`LspRename`)。 |
| `<F12>` | ノーマル/インサート | 定義元にジャンプします (`LspDefinition`)。 |
| `<C-.>` | ノーマル/インサート | コードアクションを呼び出します (`LspCodeAction`)。 |
| `<C-k><C-i>` | ノーマル/インサート | カーソル下のシンボルの情報を表示します (`LspHover`)。 |
| `<A-S-f>` | ノーマル/インサート/ビジュアル | ドキュメントまたは選択範囲をフォーマットします (`LspDocumentFormat`)。 |

### スニペット (tiny-snippet)

| キー | モード | 説明 |
|:---|:---|:---|
| `<C-j>` | ノーマル/インサート/ビジュアル | 次のプレースホルダに移動します。 |
| `<C-k>` | ノーマル/インサート/ビジュアル | 前のプレースホルダに移動します。 |
| `<C-Space>` | インサート | 補完を呼び出します。 |

### ターミナル

| キー | ターミナル | 説明 |
|:---|:---|:---|
| `<Leader><Leader>dproxy` | `export http_proxy=...` | Docker用プロキシを設定します。 |
| `<Leader><Leader>_` | | ターミナルウィンドウを最小化して次のウィンドウへ移動します。 |

### その他

| キー | ノーマルモード | 説明 |
|:---|:---|:---|
| `<Leader>fu` | | (GVim) フォントサイズを大きくします。 |
| `<Leader>fd` | | (GVim) フォントサイズを小さくします。 |
| `<Leader>o` | `:call outline#OpenOutlineBuffer()` | アウトライン表示を開きます。 |
| `<C-]>` | `:call ctags_selector#OpenTagSelector()` | タグジャンプの際にセレクタを開きます。 |
| `<Leader><Leader>` | `viwy:grep ...` | カーソル下の単語で `grep` 検索を実行します。 |
| `zz` (連続) | | カーソル行を画面中央→上端→下端→中央と順に移動させます。 |

---

## カスタムコマンド

| コマンド | 説明 |
|:---|:---|
| `:Vimrc` | `vimrc` を開きます。 |
| `:Gvimrc` | `gvimrc` を開きます。 |
| `:Tmp` | 一時ファイルを作成します。 |
| `:Teirei` | '定例' というプレフィックスの付いた一時ファイルを作成します。 |
| `:MdPreviewStart` | Markdown のプレビューを開始します (Simai が必要)。 |
| `:MdPreviewStop` | Markdown のプレビューを停止します。 |
| `:M2h` / `:M2hsc` | Markdown を HTML に変換します (pandoc が必要)。 |
| `:ToggleNumbers` | 行番号の相対表示/絶対表示を切り替えます。 |
| `:SixelPreview` | Sixel 形式の画像をプレビューします。 |
| `:Convert...` | `ConvertToLowerCamel` など、単語のケースを変換します。 |

