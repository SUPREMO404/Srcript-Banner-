k#!/data/data/com.termux/files/usr/bin/bash

clear

TURQUESA='\033[1;36m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
VERDE='\033[1;32m'
BLANCO='\033[1;37m'
RESET='\033[0m'

echo -e "${TURQUESA}"
echo "================================"
echo "    KINGSUPREMO BANNER"
echo "================================"
echo -e "${RESET}"
echo

# Instalar figlet si no existe
if ! command -v figlet >/dev/null 2>&1; then
    echo "Instalando figlet..."
    pkg update -y
    pkg install figlet -y
fi

# Pedir el texto del banner
read -rp "Escribe el texto de tu banner: " TEXTO

if [ -z "$TEXTO" ]; then
    TEXTO="PROMAN000"
fi

# Guardar el texto elegido
echo "$TEXTO" > "$HOME/.kingsupremo-text"

# Archivo para controlar el color
ARCHIVO_COLOR="$HOME/.kingsupremo-color"

if [ ! -f "$ARCHIVO_COLOR" ]; then
    echo "0" > "$ARCHIVO_COLOR"
fi

# Crear el script que mostrará el banner
cat > "$HOME/kingsupremo-banner.sh" <<'BANNER'

#!/data/data/com.termux/files/usr/bin/bash

TURQUESA='\033[1;36m'
AMARILLO='\033[1;33m'
ROJO='\033[1;31m'
VERDE='\033[1;32m'
BLANCO='\033[1;37m'
RESET='\033[0m'

ARCHIVO_COLOR="$HOME/.kingsupremo-color"

case "$NUMERO" in
    0)
        COLOR="$VERDE"
        SIGUIENTE=1
        ;;
    1)
        COLOR="$AMARILLO"
        SIGUIENTE=2
        ;;
    2)
        COLOR="$ROJO"
        SIGUIENTE=3
        ;;
    3)
        COLOR="$TURQUESA"
        SIGUIENTE=0
        ;;
    *)
        COLOR="$VERDE"
        SIGUIENTE=1
        ;;
esacif [ ! -f "$ARCHIVO_COLOR" ]; then
    echo "0" > "$ARCHIVO_COLOR"
fi

NUMERO=$(cat "$ARCHIVO_COLOR")

case "$NUMERO" in
    0)
        COLOR="$TURQUESA"
        SIGUIENTE=1
        ;;
    1)
        COLOR="$AMARILLO"
        SIGUIENTE=2
        ;;
    2)
        COLOR="$ROJO"
        SIGUIENTE=3
        ;;
    3)
        COLOR="$VERDE"
        SIGUIENTE=0
        ;;
    *)
        COLOR="$TURQUESA"
        SIGUIENTE=1
        ;;
esac

echo "$SIGUIENTE" > "$ARCHIVO_COLOR"

TEXTO=$(cat "$HOME/.kingsupremo-tecase "$NUMERO" in
    0)
        COLOR="$VERDE"
        SIGUIENTE=1
        ;;
    1)
        COLOR="$AMARILLO"
        SIGUIENTE=2
        ;;
    2)
        COLOR="$ROJO"
        SIGUIENTE=3
        ;;
    3)
        COLOR="$TURQUESA"
        SIGUIENTE=0
        ;;
    *)
        COLOR="$VERDE"
        SIGUIENTE=1
        ;;
esacxt")

clear

echo -e "${COLOR}"
figlet "$TEXTO"
echo -e "${RESET}"

echo -e "${AMARILLO}Creado por:${RESET} ${BLANCO}kingsupremo404${RESET}"

echo

BANNER

chmod +x "$HOME/kingsupremo-banner.sh"

# Eliminar instalaciones anteriores de Kingsupremo
sed -i '/# KINGSUPREMO-BANNER-START/,/# KINGSUPREMO-BANNER-END/d' "$HOME/.bashrc" 2>/dev/null

# Activar el banner al abrir Termux
cat >> "$HOME/.bashrc" <<'EOF'

# KINGSUPREMO-BANNER-START
bash "$HOME/kingsupremo-banner.sh"
# KINGSUPREMO-BANNER-END
EOF

clear

echo -e "${VERDE}================================${RESET}"
echo -e "${VERDE}     BANNER INSTALADO ✓${RESET}"
echo -e "${VERDE}================================${RESET}"
echo
echo "Tu banner aparecerá al abrir Termux."
echo

bash "$HOME/kingsupremo-banner.sh"
