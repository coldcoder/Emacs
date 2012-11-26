(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;防止在win7的卡死
(setq w32-get-true-file-attributes nil)
;;标题栏提示你在什么位置
(setq frame-title-format
	  '("  GNU Emacs   -   [ " (buffer-file-name "%f \]"
												 (dired-directory dired-directory "%b \]"))))
;;默认显示80列就换行
(setq default-fill-column 80)
;;去掉工具栏
(tool-bar-mode 0)
;;去掉菜单栏
(menu-bar-mode 0)
;;去掉滚动栏
(scroll-bar-mode 0)
;;语法高亮
(global-font-lock-mode 1)
;;一打开就是用text模式
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;;以y/n代表yes/no
(fset 'yes-or-no-p 'y-or-n-p)
;;显示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;;显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
;(setq display-time-day-and-date t)

;;Setting English Font
(set-face-attribute
  'default 0 :font "Monaco 12")
;;Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
					charset
					(font-spec :family "微软雅黑" :size 15)))
;;Color Theme
(add-to-list 'load-path "~/.emacs.d")
(require 'color-theme)
;;选择的主题
(color-theme-initialize)
(color-theme-calm-forest)
;(color-theme-blackboard)
;;自定义主题
;(load-file "~/.emacs.d/themes/pink-bliss.el")
;(pink-bliss)

;;tab缩进
(setq c-basic-offset 4)
(setq indent-tabs-mode 0)
(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list ())
(loop for x downfrom 40 to 1 do
(setq tab-stop-list (cons (* x 4) tab-stop-list)))

;;回车缩进
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key (kbd "C-<return>") 'newline)

;;显示行号
;(setq line-number-mode t)

;;设置光标为竖线
(setq-default cursor-type 'bar)
;;设置光标为方块
;;(set-defalut cursor-type 'box)

;;启动时最大化窗口
;(run-with-idle-timer 0.0 nil 'w32-send-sys-command 61448)
;;鼠标滚轮缩放字体
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(defun CuteAsura-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
	  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
	(comment-dwim arg)))
(global-set-key "\M-;" 'CuteAsura-comment-dwim-line)

;;c-set-style awk
;(add-hook 'c++-mode-hook
	;'(lambda ()
	   ;(c-set-style "awk")))
;;c++ style
(add-hook 'c++-mode-hook
	'(lambda()
		(c-set-style "stroustrup")))

;;c style
(add-hook 'c-mode-hook
	'(lambda()
		(c-set-style "k&r")))

;;拷贝代码自动格式化
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
	  (and (not current-prefix-arg)
		   (member major-mode
				   '(emacs-lisp-mode
					 lisp-mode
					 clojure-mode
					 scheme-mode
					 haskell-mode
					 ruby-mode
					 rspec-mode
					 python-mode
					 c-mode
					 c++-mode
					 objc-mode
					 latex-mode
					 js-mode
					 plain-tex-mode))
		   (let ((mark-even-if-inactive transient-mark-mode))
			 (indent-region (region-beginning) (region-end) nil))))))

;;默认工作目录
(setq default-directory "x:/Source/")
;;允许使用C-z作为命令前缀
(define-prefix-command 'ctl-z-map)
(global-set-key (kbd "C-z") 'ctl-z-map)
;;快速开打~/.emacs文件
(defun open-init-file( )
  (interactive)
  (find-file "~/.emacs"))
(global-set-key "\C-zi" 'open-init-file)
;;使用C-c m来标记文本块
(global-set-key "\C-cm" 'set-mark-command)
;;启用ibuffer支持，增强*buffer*
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;;显示行号
(global-linum-mode 1)
;;启动0.5秒后自动最大化 win
; (run-with-idle-timer 0.5 nil 'w32-send-sys-command 61448)
;;设置个人信息
(setq user-full-name "Guangyu.Zhang")
(setq user-mail-address "guangyu.zhang@gameloft.com")
;;一个大的kill ring
(setq kill-ring-max 200)
;;;;kill ring
(require 'browse-kill-ring)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
;;递归minibuffer
(setq enable-recursive-minibuffers t)
;;f5编译
(global-set-key [f5] 'compile)
;;DIRED CONFIG
(require 'dired)
(require 'dired-x)
;; C-x C-j jump to folder under where the current file is
(global-set-key "\C-x\C-j" 'dired-jump)
(define-key dired-mode-map [(control ?/)] 'dired-undo
;;;;;;;;;;;;; tabbar
(require 'tabbar)
(tabbar-mode t)
(global-set-key (kbd "M-<up>") 'tabbar-backward-group)
(global-set-key (kbd "M-<down>") 'tabbar-forward-group)
(global-set-key (kbd "M-<right>") 'tabbar-backward)
(global-set-key (kbd "M-<left>") 'tabbar-forward)
;;;;;;;;;;;; lua
(require 'lua-mode)
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-hook 'lua-mode-hook 'turn-on-font-lock)
(add-hook 'lua-mode-hook 'hs-minor-mode)
;;;;;;;;;;;;
(setq hippie-expand-try-functions-list 
      '(try-expand-dabbrev
		try-expand-dabbrev-visible
		try-expand-dabbrev-all-buffers
		try-expand-dabbrev-from-kill
		try-complete-file-name-partially
		try-complete-file-name
		try-expand-all-abbrevs
		try-expand-list
		try-expand-line))
;;;;;;;;;
(global-set-key "%" 'match-paren)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
		((looking-at "\\s\)") (forward-char 1) (backward-list 1))
		(t (self-insert-command (or arg 1)))))
