#!/bin/bash

# OrangeMark Installation Script
# Target: Linux (GTK 4 / GNOME)

APP_NAME="orangemark"
INSTALL_DIR="$HOME/.local/share/orangemark"
BIN_DIR="$HOME/.local/bin"
APPS_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/scalable/apps"

echo "🍊 Installing OrangeMark..."

# 1. Create directory structure
mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"
mkdir -p "$APPS_DIR"
mkdir -p "$ICON_DIR"

# 2. Copy project files to the local share directory
echo "📦 Copying files to $INSTALL_DIR..."
cp -r ./* "$INSTALL_DIR/"

# 3. Create a wrapper script in ~/.local/bin for easy CLI access
echo "🔗 Creating executable wrapper..."
cat <<EOF > "$BIN_DIR/$APP_NAME"
#!/bin/bash
python3 "$INSTALL_DIR/orangemark.py" "\$@"
EOF
chmod +x "$BIN_DIR/$APP_NAME"

# 4. Configure and install the .desktop file
echo "🖥️  Setting up desktop integration..."
DESKTOP_FILE="$APPS_DIR/orangemark.desktop"

# Update paths in the desktop file dynamically
sed -e "s|Exec=orangemark|Exec=$BIN_DIR/$APP_NAME|g" \
    -e "s|Icon=orangemark|Icon=$INSTALL_DIR/resources/icon.svg|g" \
    "$INSTALL_DIR/orangemark.desktop" > "$DESKTOP_FILE"

chmod +x "$DESKTOP_FILE"

# 5. Update system databases
echo "🔄 Updating desktop database and MIME types..."
update-desktop-database "$APPS_DIR"

echo "✅ Installation complete!"
echo "🚀 You can now run 'orangemark' from your terminal or find it in your App Launcher."
