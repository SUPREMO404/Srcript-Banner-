#!/data/data/com.termux/files/usr/bin/bash

clear

VERDE='\033[1;32m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
TURQUESA='\033[1;36m'
RESET='\033[0m'

echo -e "${VERDE}"
echo "=========================================="
echo "          KINGSUPREMO BANNER"
echo "=========================================="
echo -e "${RESET}"

pkg install figlet -y

read -rp "Escribe el texto de tu banner: " TEXTO
[ -z "$TEXTO" ] && TEXTO="TERMUX"

cat > "$HOME/kingsupremo-banner.sh" <<EOF
#!/data/data/com.termux/files/usr/bin/bash

VERDE='\033[1;32m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
TURQUESA='\033[1;36m'
RESET='\033[0m'

ARCHIVO="\$HOME/.kingsupremo-color"
[ -f "\$ARCHIVO" ] || echo 0 > "\$ARCHIVO"

NUM=\$(cat "\$ARCHIVO")

COLORES=(
"\$VERDE"
"\$AMARILLO"
"\$ROJO"
"\$TURQUESA"
"\$VERDE"
"\$VERDE"
"\$VERDE"
"\$VERDE"
)

COLOR="\${COLORES[\$NUM]}"

echo \$(( (NUM + 1) % 8 )) > "\$ARCHIVO"

clear

echo -e "\${COLOR}"
figlet "$TEXTO"
echo -e "\${RESET}"

echo -e "\${AMARILLO}Creado por : \${RESET}kinsupremo"
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
