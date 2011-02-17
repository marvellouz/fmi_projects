#lang racket
(require racket/gui/base)

; Make a frame by instantiating the frame% class
(define frame (new frame% [min-width 400] [min-height 200] [label "Уеб паяк"]))

(define url-text-field (new text-field% [parent frame] [min-width 100] [label "Стартов url: "]))

(define depth-text-field (new text-field% [parent frame] [min-width 100] [label "Дълбочина: "]))

(define save-path-text-field (new text-field% [parent frame] [min-width 100] [label "Запази в директория: "]))

; Make a button in the frame
(new button% [parent frame]
     [label "Старт"])

; Show the frame by calling its show method
(send frame show #t)