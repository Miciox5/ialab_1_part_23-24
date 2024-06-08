#!/bin/bash
echo '>>>>>>>> Sudoku 4x4 Facile <<<<<<<<<<'
swipl -O <<EOF
['startProject4x4facile.pl'].
main.
halt.
EOF

echo '>>>>>>>> Sudoku 4x4 Difficile <<<<<<<<<<'
swipl -O <<EOF
['startProject4x4difficile.pl'].
main.
halt.
EOF

echo '>>>>>>>> Sudoku 9x9 Facile <<<<<<<<<<'
swipl -O <<EOF
['startProject9x9facile.pl'].
main.
halt.
EOF

echo '>>>>>>>> Sudoku 9x9 Difficile <<<<<<<<<<'
swipl -O <<EOF
['startProject9x9difficile.pl'].
main.
halt.
EOF
