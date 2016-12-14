;-----
;2.72
;-----

; Consider the special case in 2.71 and the encoding procedure in 2.68:
; The most frequent symbol is in the left branch of the top level, which contains only one element, 
; therefore encoding the most frequent symbol takes O(1) time.
; The least frequent symbol is in one of the two branches of the bottom level. Encoding it needs searching down along the tree,
; which takes O(n) + O(n-1) + ... + O(1) = O(n^2) time.
