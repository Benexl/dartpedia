typedef RGB = ({int r, int g, int b});

enum Color {
  deepPetrol("#001b1f"),
  iceWhite("#e0f7fa"),
  deepForest("#004d40"),
  cyanTeal("#26a69a"),
  softMint("#4db6ac"),
  mellowYellow("#fff176"),
  solarizedBase("#002b36"),
  mutedGreyTeal("#839496"),
  electricNeon("#00ffd7"),
  officeTeal("#008080"),
  softPinkRed("#ff5f87"),
  nordDeepGrey("#2e3440"),
  frostTeal("#88c0d0"),
  blueTeal("#81a1c1"),
  seafoam("#8fbcbb"),
  deepBlack("#1a1a1b"),
  dimWhite("#d1d1d1"),
  blue("#003366"),
  white("#ffffff"),
  red("#ff1010"),
  gray("#72777D"),
  silver("#AFB0B1");

  final String hex;
  const Color(this.hex);

  RGB toRGB() {
    var cleanHex = hex.replaceAll("#", "");
    int hexInt = int.parse(cleanHex, radix: 16);
    return (
      r: (hexInt >> 16) & 0xFF,
      g: (hexInt >> 8) & 0xFF,
      b: hexInt & 0xFF,
    );
  }
}

//
// --- Arctic Petrol Theme Colors ---
//
// Element,Hex Code,Descriptive Name,Use Case
// Background,#001B1F,Deep Petrol,Main terminal background
// Foreground,#E0F7FA,Ice White,Primary body text
// Selection,#004D40,Deep Forest,Highlighted text background
// Accent 1,#26A69A,Cyan Teal,Links or secondary headers
// Accent 2,#4DB6AC,Soft Mint,Metadata or tags
// Contrast,#FFF176,Mellow Yellow,Warnings or search matches

//
// --- Electric Solarized Theme Colors ---
//
// Element,Hex Code,Descriptive Name,Why it works
// Background,#002B36,Solarized Base,Proven eye-comfort base
// Foreground,#839496,Muted Grey-Teal,Low-glare reading text
// Bold Accent,#00FFD7,Electric Neon,Active links or cursors
// Subtle Accent,#008080,Office Teal,Borders or table lines
// Error,#FF5F87,Soft Pink-Red,Error messages or missing refs

//
// --- Nordic Frost Theme Colors ---
//
// Element,Hex Code,Descriptive Name,Use Case
// Background,#2E3440,Nord Deep Grey,"The ""canvas"""
// Main Teal,#88C0D0,Frost Teal,Primary Headers (H1)
// Secondary,#81A1C1,Blue-Teal,Sub-headers (H2)
// Highlight,#8FBCBB,Seafoam,Selected text or bold words

//
// --- Wikipedia Classic Theme Colors ---
//
// Element,Hex Code,ANSI Mapping,Use Case
// Background,#1A1A1B,Deep Black,Reduces glare for long articles
// Text,#D1D1D1,Dim White,Easy-to-read content body
// Links,#003366,Blue,Iconic Wikipedia link color
// Headings,#FFFFFF,Bold White,Strong visual hierarchy
// Red Links,#FF1010,Red,Non-existent pages
// Metadata,#72777D,Gray,"Citations, dates, and ""Edited by"""
// Accents,#AFB0B1,Silver,"Borders, tables, and rules (---)"
