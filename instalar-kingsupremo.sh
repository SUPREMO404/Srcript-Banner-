#!/data/data/com.termux/files/usr/bin/bash

# Colores
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
AZUL='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
VERDE='\033[1;32m'
RESET='\033[0m'

clear

echo -e "${AMARILLO}"
echo "=============================================="
echo "       INSTALADOR KINGSUPREMO BANNER"
echo "=============================================="
echo -e "${RESET}"

# Crear el banner
cat > "$HOME/kingsupremo-banner.sh" <<'BANNER'
#!/data/data/com.termux/files/usr/bin/bash

AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
AZUL='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
VERDE='\033[1;32m'
RESET='\033[0m'

COLORES=("$AMARILLO" "$ROJO" "$AZUL" "$MAGENTA" "$CYAN")
COLOR="${COLORES[$RANDOM % ${#COLORES[@]}]}"

clear

echo -e "${COLOR}"
echo "██╗  ██╗██╗███╗   ██╗ ██████╗"
echo "██║ ██╔╝██║████╗  ██║██╔════╝"
echo "█████╔╝ ██║██╔██╗ ██║██║  ███╗"
echo "██╔═██╗ ██║██║╚██╗██║██║   ██║"
echo "██║  ██╗██║██║ ╚████║╚██████╔╝"
echo "╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝"
echo -e "${RESET}"

echo -e "${VERDE}"
echo "======================================"
echo "       CREADO POR KINGSUPREMO"
echo "======================================"
echo -e "${RESET}"
echo
BANNER

chmod +x "$HOME/kingsupremo-banner.sh"

# Activar al abrir Termux
touch "$HOME/.bashrc"
sed -i '/kingsupremo-banner.sh/d' "$HOME/.bashrc"
echo 'bash "$HOME/kingsupremo-banner.sh"' >> "$HOME/.bashrc"

echo
echo -e "${VERDE}[✓] BANNER INSTALADO${RESET}"
echo

bash "$HOME/kingsupremo-banner.sh"

exit
