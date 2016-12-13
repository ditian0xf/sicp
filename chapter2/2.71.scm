;-----
;2.71
;-----

; n = 5
; frequencies [1, 2, 4, 8, 16]
;                   +
;                 /   \
;               16     +
;                    /   \
;                   8     +
;                       /   \
;                      4     +
;                           / \
;                          2   1

; n = 10
; frequencies [1, 2, 4, 8, 16, 32, 64, 128, 256, 512]
;                   +
;                 /   \
;               512    +
;                    /   \
;                  256    +
;                       /   \
;                     128    +
;                          /   \
;                         64    +
;                             /   \
;                            32    +
;                                /   \
;                               16    +
;                                   /   \
;                                  8     +
;                                      /   \
;                                     4     +
;                                          / \
;                                         2   1

; 1 bit is required to encode the most frequent symbol, 
; (n - 1) bits are required to encode the least frequent symbol.
