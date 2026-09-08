#!/data/data/com.termux/files/usr/bin/bash

clear

TURQUESA='\033[1;36m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
VERDE='\033[1;32m'
RESET='\033[0m'

echo -e "${TURQUESA}"
echo "=========================================="
echo "          KINGSUPREMO BANNER"
echo "=========================================="
echo -e "${RESET}"
echo

pkg install figlet -y

read -rp "Escribe el texto de tu banner: " TEXTO
[ -z "$TEXTO" ] && TEXTO="TERMUX"

cat > "$HOME/kingsupremo-banner.sh" <<EOF
#!/data/data/com.termux/files/usr/bin/bash

TURQUESA='\033[1;36m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
VERDE='\033[1;32m'
RESET='\033[0m'

COLORES=("\$TURQUESA" "\$AMARILLO" "\$ROJO")
COLOR="\${COLORES[\$RANDOM % \${#COLORES[@]}]}"

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
echo -e "${VERDE}==========================================${RESET}"
echo -e "${VERDE}          BANNER INSTALADO ✓${RESET}"
echo -e "${VERDE}==========================================${RESET}"
echo
echo "Tu banner aparecerá al abrir Termux."
echo

bash "$HOME/kingsupremo-banner.sh"
