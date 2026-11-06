#!/data/data/com.termux/files/usr/bin/bash

clear

VERDE='\033[1;32m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
TURQUESA='\033[1;36m'
NARANJA='\033[38;5;208m'
ROSADO='\033[38;5;205m'
AZUL='\033[38;5;39m'
RESET='\033[0m'

echo -e "${AMARILLO}"
echo "=========================================="
echo "🔥 ☣️ 👽 CREADO POR : KINGSUPREMO404 👽 ☣️ 🔥"
echo "=========================================="
echo -e "${RESET}"

pkg install figlet -y

read -rp "Escribe el texto de tu banner: " TEXTO
[ -z "$TEXTO" ] && TEXTO="TERMUX"

printf -v TEXTO_ESCAPADO '%q' "$TEXTO"

cat > "$HOME/kingsupremo-banner.sh" <<EOF
#!/data/data/com.termux/files/usr/bin/bash

VERDE='\033[1;32m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
TURQUESA='\033[1;36m'
NARANJA='\033[38;5;208m'
ROSADO='\033[38;5;205m'
AZUL='\033[38;5;39m'
RESET='\033[0m'

ARCHIVO="\$HOME/.kingsupremo-color"
[ -f "\$ARCHIVO" ] || echo 0 > "\$ARCHIVO"

NUM=\$(cat "\$ARCHIVO")
[[ "\$NUM" =~ ^[0-7]$ ]] || NUM=0

COLORES=(
"\$VERDE"
"\$AMARILLO"
"\$ROJO"
"\$TURQUESA"
"\$NARANJA"
"\$ROSADO"
"\$AZUL"
"\$VERDE"
)

COLOR="\${COLORES[\$NUM]}"
echo \$(( (NUM + 1) % 8 )) > "\$ARCHIVO"

clear

echo -e "\$COLOR"

# AQUI ESTA LA CORRECCION PARA ALINEAR A LA IZQUIERDA
figlet $TEXTO_ESCAPADO | while IFS= read -r LINEA; do
    # Eliminar espacios en blanco al final de la línea
    LINEA_LIMPIA="\${LINEA%"\${LINEA##*[![:space:]]}"}"
    # Imprimir directamente (sin espacios extra a la izquierda)
    echo "\$LINEA_LIMPIA"
done

echo -e "\$RESET"
echo
EOF

chmod +x "$HOME/kingsupremo-banner.sh"

sed -i '/# KINGSUPREMO-BANNER-START/,/# KINGSUPREMO-BANNER-END/d' "$HOME/.bashrc" 2>/dev/null

cat >> "$HOME/.bashrc" <<'EOF'

# KINGSUPREMO-BANNER-START
bash "$HOME/kingsupremo-banner.sh"
# KINGSUPREMO-BANNER-END
EOF

echo
echo -e "${VERDE}BANNER INSTALADO ✓${RESET}"
echo

bash "$HOME/kingsupremo-banner.sh"
