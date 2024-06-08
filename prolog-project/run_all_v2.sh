#!/bin/bash
echo '>>>>>>>> Sudoku 4x4 Facile v2 <<<<<<<<<<'
swipl -O <<EOF
['startProject4x4facile_v2.pl'].
main.
halt.
EOF

echo '>>>>>>>> Sudoku 4x4 Difficile v2 <<<<<<<<<<'
swipl -O <<EOF
['startProject4x4difficile_v2.pl'].
main.
halt.
EOF

echo '>>>>>>>> Sudoku 9x9 Facile v2 <<<<<<<<<<'
swipl -O <<EOF
['startProject9x9facile_v2.pl'].
main.
halt.
EOF

echo '>>>>>>>> Sudoku 9x9 Difficile v2 <<<<<<<<<<'
swipl -O <<EOF
['startProject9x9difficile_v2.pl'].
main.
halt.
EOF
