<?xml version="1.0" encoding="UTF-8"?>
<!-- This file was generated on Fri Apr 15, 2022 14:16 (UTC+02) by REx v5.55 which is Copyright (c) 1979-2022 by Gunther Rademacher <grd@gmx.net> -->
<!-- REx command line: CSS3Selectors(1).ebnf -xslt -tree -->

<xsl:stylesheet version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:p="http://www.nkutsche.com/css-parser">
  <!--~
   ! The index of the lexer state for accessing the combined
   ! (i.e. level > 1) lookahead code.
  -->
  <xsl:variable name="p:lk" as="xs:integer" select="1"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the begin of the token that has been consumed.
  -->
  <xsl:variable name="p:b0" as="xs:integer" select="2"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the end of the token that has been consumed.
  -->
  <xsl:variable name="p:e0" as="xs:integer" select="3"/>

  <!--~
   ! The index of the lexer state for accessing the code of the
   ! level-1-lookahead token.
  -->
  <xsl:variable name="p:l1" as="xs:integer" select="4"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the begin of the level-1-lookahead token.
  -->
  <xsl:variable name="p:b1" as="xs:integer" select="5"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the end of the level-1-lookahead token.
  -->
  <xsl:variable name="p:e1" as="xs:integer" select="6"/>

  <!--~
   ! The index of the lexer state for accessing the code of the
   ! level-2-lookahead token.
  -->
  <xsl:variable name="p:l2" as="xs:integer" select="7"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the begin of the level-2-lookahead token.
  -->
  <xsl:variable name="p:b2" as="xs:integer" select="8"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the end of the level-2-lookahead token.
  -->
  <xsl:variable name="p:e2" as="xs:integer" select="9"/>

  <!--~
   ! The index of the lexer state for accessing the code of the
   ! level-3-lookahead token.
  -->
  <xsl:variable name="p:l3" as="xs:integer" select="10"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the begin of the level-3-lookahead token.
  -->
  <xsl:variable name="p:b3" as="xs:integer" select="11"/>

  <!--~
   ! The index of the lexer state for accessing the position in the
   ! input string of the end of the level-3-lookahead token.
  -->
  <xsl:variable name="p:e3" as="xs:integer" select="12"/>

  <!--~
   ! The index of the lexer state for accessing the token code that
   ! was expected when an error was found.
  -->
  <xsl:variable name="p:error" as="xs:integer" select="13"/>

  <!--~
   ! The index of the lexer state that points to the first entry
   ! used for collecting action results.
  -->
  <xsl:variable name="p:result" as="xs:integer" select="14"/>

  <!--~
   ! The codepoint to charclass mapping for 7 bit codepoints.
  -->
  <xsl:variable name="p:MAP0" as="xs:integer+" select="
    0, 0, 0, 0, 0, 0, 0, 0, 0, 37, 1, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 37, 4, 5, 6, 7, 4, 4, 8, 9, 10, 11, 12, 13, 14, 15, 4, 16,
    17, 17, 17, 18, 19, 20, 19, 17, 17, 21, 4, 4, 22, 23, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 24, 25, 26, 27,
    28, 4, 29, 29, 29, 29, 30, 31, 28, 28, 28, 28, 28, 28, 28, 32, 33, 28, 28, 28, 28, 34, 28, 28, 28, 28, 28, 28, 4, 35, 4, 36, 4
  "/>

  <!--~
   ! The codepoint to charclass mapping for codepoints below the surrogate block.
  -->
  <xsl:variable name="p:MAP1" as="xs:integer+" select="
    54, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62,
    62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 133, 126, 149, 185, 164, 169, 200, 228, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216,
    216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216,
    216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 216, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 37, 1, 0, 2, 3, 0, 0, 37, 4, 5, 6, 7, 4, 4, 8, 9, 10, 11, 12, 13, 14, 15, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 24, 25, 26, 27, 28, 16, 17, 17,
    17, 18, 19, 20, 19, 17, 17, 21, 4, 4, 22, 23, 4, 29, 29, 29, 29, 30, 31, 28, 28, 28, 28, 28, 28, 28, 32, 33, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
    28, 28, 28, 28, 34, 28, 28, 28, 28, 28, 28, 4, 35, 4, 36, 4
  "/>

  <!--~
   ! The codepoint to charclass mapping for codepoints above the surrogate block.
  -->
  <xsl:variable name="p:MAP2" as="xs:integer+" select="
    57344, 65536, 65533, 1114111, 28, 28
  "/>

  <!--~
   ! The token-set-id to DFA-initial-state mapping.
  -->
  <xsl:variable name="p:INITIAL" as="xs:integer+" select="
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 275, 276, 277
  "/>

  <!--~
   ! The DFA transition table.
  -->
  <xsl:variable name="p:TRANSITION" as="xs:integer+" select="
    615, 615, 615, 615, 615, 615, 615, 615, 615, 615, 615, 615, 615, 615, 615, 615, 1510, 608, 625, 614, 642, 651, 1170, 668, 677, 686, 1153, 1627, 882, 909,
    1069, 615, 1510, 608, 625, 614, 642, 651, 1088, 1553, 1629, 698, 1067, 1627, 1557, 1068, 1069, 615, 1510, 608, 625, 614, 642, 716, 810, 1600, 758, 734, 746,
    756, 1604, 747, 748, 615, 615, 615, 1087, 1128, 615, 1538, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 616, 1649, 1087, 1643, 615, 1538, 766, 794,
    704, 615, 706, 702, 615, 707, 708, 615, 615, 928, 1580, 1128, 615, 1538, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 615, 630, 634, 1128, 615,
    1538, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 643, 1655, 1087, 1504, 615, 1538, 766, 806, 770, 615, 772, 768, 615, 773, 774, 615, 615, 615,
    1087, 1025, 615, 1451, 818, 782, 1450, 1043, 826, 1448, 1044, 827, 1104, 615, 837, 835, 1302, 1128, 615, 1538, 766, 782, 1537, 615, 1102, 617, 615, 1103,
    1104, 615, 845, 849, 857, 1128, 615, 1538, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 615, 1037, 989, 1128, 1042, 875, 766, 782, 1537, 615, 1102,
    617, 615, 1103, 1104, 615, 615, 615, 1018, 1128, 615, 895, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 1354, 1347, 1168, 996, 738, 918, 902, 668,
    677, 926, 1067, 675, 672, 1068, 1069, 615, 615, 1661, 936, 1368, 615, 1538, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 615, 1031, 690, 943, 738,
    951, 1474, 959, 974, 982, 1004, 1052, 1060, 1077, 1069, 615, 615, 1031, 690, 943, 738, 951, 1383, 1096, 966, 1112, 1122, 726, 1146, 1297, 1069, 615, 615,
    1031, 690, 943, 738, 951, 1525, 1161, 1178, 1186, 1198, 1248, 1224, 1243, 1069, 615, 615, 1031, 690, 943, 738, 951, 1383, 1096, 966, 1256, 1122, 1260, 1268,
    1276, 1315, 615, 615, 1031, 690, 943, 738, 951, 1525, 1161, 1178, 1186, 1198, 1190, 1224, 1243, 1069, 615, 615, 1332, 1340, 1128, 615, 1538, 766, 782, 1537,
    615, 1102, 617, 615, 1103, 1104, 615, 615, 1320, 1324, 1128, 1362, 1538, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 615, 615, 1011, 1128, 615,
    1376, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 615, 798, 1391, 1128, 615, 1538, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 1212,
    1216, 1205, 1398, 1114, 1283, 1405, 1421, 1436, 1444, 1459, 1428, 1425, 1412, 1413, 615, 1134, 1134, 1138, 1128, 615, 1538, 766, 782, 1537, 615, 1102, 617,
    615, 1103, 1104, 615, 615, 656, 660, 1128, 615, 1538, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 863, 867, 1585, 1683, 738, 678, 902, 668, 677,
    926, 1067, 675, 672, 1068, 1069, 615, 863, 867, 1307, 1467, 738, 1482, 1383, 1096, 966, 1112, 1122, 726, 1146, 1297, 1069, 615, 863, 867, 1307, 1467, 738,
    1482, 1383, 1490, 966, 1112, 1122, 726, 1146, 1297, 1069, 615, 863, 867, 1307, 1467, 738, 1482, 1383, 1096, 966, 1498, 1122, 726, 1146, 1297, 1069, 615,
    863, 867, 1585, 1683, 786, 678, 1290, 668, 677, 926, 1067, 675, 672, 1068, 1069, 615, 863, 867, 1585, 1683, 738, 678, 1235, 668, 1518, 1533, 1231, 675, 672,
    1068, 1069, 615, 863, 867, 1585, 1683, 738, 678, 902, 668, 887, 1546, 1067, 915, 912, 1068, 1069, 615, 1084, 1565, 1573, 1128, 615, 1538, 766, 782, 1537,
    615, 1102, 617, 615, 1103, 1104, 615, 615, 721, 1593, 1128, 615, 1612, 766, 782, 1537, 615, 1102, 617, 615, 1103, 1104, 615, 1510, 608, 1620, 1637, 642,
    1669, 1677, 668, 1629, 698, 1067, 1627, 1557, 1068, 1069, 615, 409, 0, 409, 417, 409, 417, 409, 0, 0, 0, 0, 0, 0, 0, 0, 29, 30, 409, 409, 425, 425, 425, 0,
    0, 0, 0, 34, 0, 0, 0, 0, 0, 1176, 0, 417, 0, 0, 0, 0, 0, 0, 0, 30, 425, 1176, 1180, 29, 30, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 1176, 0, 29, 29, 30, 30, 2481,
    1703, 0, 0, 0, 0, 0, 1176, 1180, 29, 30, 2481, 2481, 2481, 1703, 1703, 0, 52, 0, 0, 0, 0, 0, 0, 1194, 1176, 0, 1703, 0, 52, 0, 0, 0, 0, 0, 0, 1280, 30, 0,
    0, 0, 0, 0, 0, 425, 1205, 1207, 57, 59, 0, 0, 0, 0, 38, 0, 0, 0, 0, 1256, 1257, 106, 107, 0, 1737, 0, 88, 0, 0, 0, 0, 0, 0, 1703, 0, 1205, 1207, 57, 59,
    2503, 1737, 0, 0, 0, 0, 0, 101, 0, 0, 1205, 1207, 57, 59, 0, 2503, 0, 1703, 0, 0, 0, 0, 0, 0, 29, 1280, 0, 0, 0, 0, 0, 0, 29, 29, 30, 30, 0, 0, 0, 0, 0, 0,
    1703, 52, 1280, 1280, 30, 30, 0, 0, 0, 0, 0, 0, 3328, 3328, 29, 29, 1280, 1280, 0, 0, 0, 0, 0, 1205, 0, 1207, 0, 1703, 0, 0, 0, 0, 1408, 1408, 0, 1408, 29,
    30, 0, 0, 0, 0, 2304, 2560, 0, 0, 0, 0, 2560, 0, 0, 0, 0, 0, 2688, 0, 0, 0, 0, 2688, 0, 35, 0, 2688, 2688, 35, 2688, 0, 0, 0, 0, 1176, 0, 0, 0, 0, 1180,
    1176, 1176, 0, 1176, 1176, 1176, 1792, 0, 0, 29, 30, 0, 0, 2481, 1703, 0, 0, 66, 0, 80, 1176, 1180, 29, 30, 2481, 2481, 2048, 0, 0, 29, 30, 0, 0, 2481,
    1703, 0, 0, 1176, 1176, 1180, 1180, 29, 30, 2481, 1703, 0, 0, 80, 0, 0, 1176, 1180, 29, 30, 47, 0, 2481, 1703, 1703, 0, 0, 0, 0, 0, 0, 39, 39, 0, 2944,
    2944, 2944, 2944, 0, 1176, 0, 0, 1195, 1180, 29, 30, 1582, 1568, 0, 1206, 1208, 58, 60, 1582, 0, 2493, 29, 69, 30, 70, 2504, 1738, 75, 0, 0, 1233, 1234, 83,
    84, 2481, 2517, 77, 0, 1233, 1234, 83, 84, 2481, 2517, 1703, 1750, 87, 0, 89, 0, 91, 0, 0, 1792, 1792, 1792, 0, 1176, 0, 0, 1180, 1180, 29, 30, 0, 47, 1245,
    1246, 95, 96, 2529, 1762, 99, 0, 0, 1920, 1920, 1920, 0, 1176, 0, 0, 2048, 2048, 2048, 0, 1176, 0, 0, 1180, 1408, 29, 30, 0, 0, 0, 1568, 0, 1568, 0, 0, 0,
    1792, 0, 1792, 0, 0, 0, 0, 0, 0, 0, 2304, 0, 100, 0, 102, 0, 1256, 1257, 106, 107, 2540, 1773, 0, 110, 0, 111, 0, 1176, 1180, 29, 30, 2481, 1703, 0, 0, 0,
    0, 1180, 113, 114, 2547, 1780, 0, 117, 0, 0, 3584, 0, 0, 0, 0, 0, 0, 1176, 0, 1180, 29, 69, 30, 70, 2504, 1738, 0, 0, 29, 30, 0, 0, 0, 0, 0, 0, 1703, 1750,
    0, 0, 0, 0, 0, 0, 50, 51, 1245, 1246, 95, 96, 2529, 1762, 0, 0, 1180, 0, 29, 30, 0, 0, 0, 0, 3456, 0, 0, 0, 0, 0, 1176, 0, 2540, 1773, 0, 0, 0, 0, 0, 1176,
    1180, 29, 30, 2481, 1703, 0, 52, 29, 69, 30, 70, 2504, 1738, 64, 0, 22, 0, 0, 0, 0, 1176, 1176, 1180, 1180, 78, 0, 1233, 1234, 83, 84, 2481, 2517, 1703,
    1750, 64, 0, 78, 0, 0, 0, 1256, 1257, 106, 107, 1245, 1246, 95, 96, 2529, 1762, 64, 0, 23, 0, 0, 0, 23, 1176, 23, 0, 0, 0, 0, 27, 23, 23, 0, 23, 23, 23,
    2540, 1773, 64, 78, 0, 0, 0, 1176, 1180, 29, 30, 2481, 1703, 0, 66, 1176, 1176, 1180, 1180, 1180, 113, 114, 2547, 1780, 78, 0, 0, 103, 1256, 1257, 106, 107,
    1703, 1750, 0, 0, 0, 0, 92, 0, 1256, 1257, 106, 107, 2540, 1773, 0, 0, 0, 92, 0, 1176, 1180, 113, 114, 2547, 1780, 0, 92, 0, 23, 27, 29, 30, 48, 48, 2481,
    1703, 52, 0, 1176, 1176, 1180, 1180, 113, 114, 2547, 1780, 0, 0, 0, 0, 2560, 0, 1176, 0, 0, 0, 1176, 1194, 1176, 29, 30, 2481, 1703, 92, 0, 0, 0, 0, 3200,
    0, 0, 0, 0, 0, 1176, 0, 0, 3072, 0, 0, 0, 0, 3072, 3112, 0, 3112, 3112, 3112, 3112, 0, 1176, 0, 26, 22, 2838, 0, 2838, 22, 22, 0, 0, 0, 0, 26, 22, 22, 0,
    896, 1024, 768, 640, 512, 0, 0, 1180, 0, 29, 30, 0, 31, 1920, 0, 0, 29, 30, 0, 0, 2481, 1726, 0, 0, 1176, 1219, 1180, 1220, 0, 3328, 3328, 3328, 3328, 0,
    1176, 0, 27, 1180, 27, 44, 45, 0, 48, 1703, 0, 65, 23, 23, 27, 27, 44, 45, 48, 50, 0, 0, 0, 0, 44, 44, 45, 45, 48, 50, 0, 0, 79, 0, 0, 23, 27, 44, 45, 0,
    79, 23, 27, 44, 45, 48, 48, 50, 50, 0, 65, 0, 0, 0, 0, 0, 1408, 29, 30, 0, 0, 2481, 23, 27, 44, 45, 48, 50, 0, 65, 0, 1180, 1195, 1180, 29, 30, 0, 2481,
    1726, 63, 0, 1176, 1219, 1180, 1220, 0, 1206, 1208, 58, 60, 2481, 2481, 2493, 29, 69, 30, 70, 2504, 1738, 0, 76, 1703, 1750, 0, 0, 0, 90, 0, 0, 1180, 0, 29,
    1280, 0, 0, 0, 409, 409, 0, 0, 409, 66, 0, 1176, 1180, 29, 30, 2481, 2481, 1726, 64, 0, 1176, 1219, 1180, 1220, 1703, 1703, 0, 66, 0, 0, 0, 0, 29, 30, 0, 0,
    2481, 1703, 1703, 0, 0, 0, 0, 80, 0, 29, 0, 30, 2481, 1703, 0, 0, 0, 0, 80, 1176, 3584, 0, 3584, 0, 37, 0, 3584, 3584, 3621, 3584, 0, 3584, 3584, 0, 1176,
    0, 39, 39, 39, 39, 0, 1176, 0, 0, 0, 1176, 1176, 1176, 38, 0, 2176, 2176, 2176, 0, 1176, 0, 57, 0, 59, 2503, 1737, 0, 0, 0, 0, 112, 1205, 2176, 0, 0, 29,
    30, 0, 0, 2481, 409, 409, 425, 425, 425, 0, 1176, 0, 66, 0, 0, 1176, 1180, 29, 30, 0, 2481, 409, 0, 1180, 0, 29, 30, 0, 0, 1180, 0, 1280, 30, 0, 0, 0, 29,
    0, 29, 0, 0, 0, 30, 0, 30, 0, 0, 0, 31, 0, 31, 2944, 2944, 425, 1176, 1180, 29, 30, 0, 0, 2481, 0, 1703, 0, 0, 0, 1176, 0, 1180, 1180, 1180, 29, 30, 0,
    2481
  "/>

  <!--~
   ! The DFA-state to expected-token-set mapping.
  -->
  <xsl:variable name="p:EXPECTED" as="xs:integer+" select="
    30, 34, 38, 42, 46, 50, 56, 60, 64, 68, 72, 79, 82, 52, 89, 82, 85, 91, 95, 97, 73, 82, 97, 73, 82, 84, 74, 83, 75, 85, 256, 1048576, 134217728, 524292,
    67108868, 1280, 1048832, 772, 134742020, 8389888, 135266564, 2370308, 83886332, 2894596, 181408004, 181539072, 218104060, 181539076, 46395396, 180613124,
    181137412, 256, 256, 256, 1280, 1280, 4, 1280, 1280, 1280, 512, 512, 264192, 264192, 8196, 64, 128, 32, 16, 8, 4096, 131072, 122884, 256, 1280, 512, 512,
    262144, 4096, 512, 264192, 262144, 262144, 4096, 131072, 131072, 131072, 256, 1280, 512, 512, 512, 512, 262144, 262144, 4096, 4096, 131072, 131072, 131072,
    131072
  "/>

  <!--~
   ! The token-string table.
  -->
  <xsl:variable name="p:TOKEN" as="xs:string+" select="
    '(0)',
    'END',
    'S',
    &quot;'~='&quot;,
    &quot;'|='&quot;,
    &quot;'^='&quot;,
    &quot;'$='&quot;,
    &quot;'*='&quot;,
    'IDENT',
    'STRING',
    'FUNCTION',
    'NUMBER',
    'HASH',
    'PLUS',
    'GREATER',
    'COMMA',
    'TILDE',
    'NOT',
    'DIMENSION',
    &quot;')'&quot;,
    &quot;'*'&quot;,
    &quot;'-'&quot;,
    &quot;'.'&quot;,
    &quot;':'&quot;,
    &quot;'='&quot;,
    &quot;'['&quot;,
    &quot;']'&quot;,
    &quot;'|'&quot;
  "/>

  <!--~
   ! Match next token in input string, starting at given index, using
   ! the DFA entry state for the set of tokens that are expected in
   ! the current context.
   !
   ! @param $input the input string.
   ! @param $begin the index where to start in input string.
   ! @param $token-set the expected token set id.
   ! @return a sequence of three: the token code of the result token,
   ! with input string begin and end positions. If there is no valid
   ! token, return the negative id of the DFA state that failed, along
   ! with begin and end positions of the longest viable prefix.
  -->
  <xsl:function name="p:match" as="xs:integer+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="begin" as="xs:integer"/>
    <xsl:param name="token-set" as="xs:integer"/>

    <xsl:variable name="result" select="$p:INITIAL[1 + $token-set]"/>
    <xsl:sequence select="p:transition($input, $begin, $begin, $begin, $result, $result mod 128, 0)"/>
  </xsl:function>

  <!--~
   ! The DFA state transition function. If we are in a valid DFA state, save
   ! it's result annotation, consume one input codepoint, calculate the next
   ! state, and use tail recursion to do the same again. Otherwise, return
   ! any valid result or a negative DFA state id in case of an error.
   !
   ! @param $input the input string.
   ! @param $begin the begin index of the current token in the input string.
   ! @param $current the index of the current position in the input string.
   ! @param $end the end index of the result in the input string.
   ! @param $result the result code.
   ! @param $current-state the current DFA state.
   ! @param $previous-state the  previous DFA state.
   ! @return a sequence of three: the token code of the result token,
   ! with input string begin and end positions. If there is no valid
   ! token, return the negative id of the DFA state that failed, along
   ! with begin and end positions of the longest viable prefix.
  -->
  <xsl:function name="p:transition">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="begin" as="xs:integer"/>
    <xsl:param name="current" as="xs:integer"/>
    <xsl:param name="end" as="xs:integer"/>
    <xsl:param name="result" as="xs:integer"/>
    <xsl:param name="current-state" as="xs:integer"/>
    <xsl:param name="previous-state" as="xs:integer"/>

    <xsl:choose>
      <xsl:when test="$current-state eq 0">
        <xsl:variable name="result" select="$result idiv 128"/>
        <xsl:variable name="end" select="if ($end gt string-length($input)) then string-length($input) + 1 else $end"/>
        <xsl:sequence select="
          if ($result ne 0) then
          (
            $result - 1,
            $begin,
            $end
          )
          else
          (
            - $previous-state,
            $begin,
            $current - 1
          )
        "/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="c0" select="(string-to-codepoints(substring($input, $current, 1)), 0)[1]"/>
        <xsl:variable name="c1" as="xs:integer">
          <xsl:choose>
            <xsl:when test="$c0 &lt; 128">
              <xsl:sequence select="$p:MAP0[1 + $c0]"/>
            </xsl:when>
            <xsl:when test="$c0 &lt; 55296">
              <xsl:variable name="c1" select="$c0 idiv 16"/>
              <xsl:variable name="c2" select="$c1 idiv 64"/>
              <xsl:sequence select="$p:MAP1[1 + $c0 mod 16 + $p:MAP1[1 + $c1 mod 64 + $p:MAP1[1 + $c2]]]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="p:map2($c0, 1, 2)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="current" select="$current + 1"/>
        <xsl:variable name="i0" select="128 * $c1 + $current-state - 1"/>
        <xsl:variable name="i1" select="$i0 idiv 8"/>
        <xsl:variable name="next-state" select="$p:TRANSITION[$i0 mod 8 + $p:TRANSITION[$i1 + 1] + 1]"/>
        <xsl:sequence select="
          if ($next-state &gt; 127) then
            p:transition($input, $begin, $current, $current, $next-state, $next-state mod 128, $current-state)
          else
            p:transition($input, $begin, $current, $end, $result, $next-state, $current-state)
        "/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Recursively translate one 32-bit chunk of an expected token bitset
   ! to the corresponding sequence of token strings.
   !
   ! @param $result the result of previous recursion levels.
   ! @param $chunk the 32-bit chunk of the expected token bitset.
   ! @param $base-token-code the token code of bit 0 in the current chunk.
   ! @return the set of token strings.
  -->
  <xsl:function name="p:token">
    <xsl:param name="result" as="xs:string*"/>
    <xsl:param name="chunk" as="xs:integer"/>
    <xsl:param name="base-token-code" as="xs:integer"/>

    <xsl:sequence select="
      if ($chunk = 0) then
        $result
      else
        p:token
        (
          ($result, if ($chunk mod 2 != 0) then $p:TOKEN[$base-token-code] else ()),
          if ($chunk &lt; 0) then $chunk idiv 2 + 2147483648 else $chunk idiv 2,
          $base-token-code + 1
        )
    "/>
  </xsl:function>

  <!--~
   ! Calculate expected token set for a given DFA state as a sequence
   ! of strings.
   !
   ! @param $state the DFA state.
   ! @return the set of token strings
  -->
  <xsl:function name="p:expected-token-set" as="xs:string*">
    <xsl:param name="state" as="xs:integer"/>

    <xsl:if test="$state > 0">
      <xsl:for-each select="0 to 0">
        <xsl:variable name="i0" select=". * 117 + $state - 1"/>
        <xsl:variable name="i1" select="$i0 idiv 4"/>
        <xsl:sequence select="p:token((), $p:EXPECTED[$i0 mod 4 + $p:EXPECTED[$i1 + 1] + 1], . * 32 + 1)"/>
      </xsl:for-each>
    </xsl:if>
  </xsl:function>

  <!--~
   ! Classify codepoint by doing a tail recursive binary search for a
   ! matching codepoint range entry in MAP2, the codepoint to charclass
   ! map for codepoints above the surrogate block.
   !
   ! @param $c the codepoint.
   ! @param $lo the binary search lower bound map index.
   ! @param $hi the binary search upper bound map index.
   ! @return the character class.
  -->
  <xsl:function name="p:map2" as="xs:integer">
    <xsl:param name="c" as="xs:integer"/>
    <xsl:param name="lo" as="xs:integer"/>
    <xsl:param name="hi" as="xs:integer"/>

    <xsl:variable name="m" select="($hi + $lo) idiv 2"/>
    <xsl:choose>
      <xsl:when test="$lo &gt; $hi">
        <xsl:sequence select="0"/>
      </xsl:when>
      <xsl:when test="$p:MAP2[$m] &gt; $c">
        <xsl:sequence select="p:map2($c, $lo, $m - 1)"/>
      </xsl:when>
      <xsl:when test="$p:MAP2[2 + $m] &lt; $c">
        <xsl:sequence select="p:map2($c, $m + 1, $hi)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="$p:MAP2[4 + $m]"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production combinator (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-combinator-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>      <!-- S | IDENT | HASH | NOT | '*' | '.' | ':' | '[' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-combinator-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 2nd loop of production combinator (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-combinator-2">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>      <!-- S | IDENT | HASH | NOT | '*' | '.' | ':' | '[' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-combinator-2($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 3rd loop of production combinator (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-combinator-3">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>      <!-- S | IDENT | HASH | NOT | '*' | '.' | ':' | '[' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-combinator-3($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 4th loop of production combinator (one or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-combinator-4">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:consume(2, $input, $state)"/>          <!-- S -->
        <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>      <!-- S | IDENT | HASH | NOT | '*' | '.' | ':' | '[' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="p:parse-combinator-4($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse combinator.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-combinator" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 13">                                        <!-- PLUS -->
          <xsl:variable name="state" select="p:consume(13, $input, $state)"/>       <!-- PLUS -->
          <xsl:variable name="state" select="p:parse-combinator-1($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 14">                                        <!-- GREATER -->
          <xsl:variable name="state" select="p:consume(14, $input, $state)"/>       <!-- GREATER -->
          <xsl:variable name="state" select="p:parse-combinator-2($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 16">                                        <!-- TILDE -->
          <xsl:variable name="state" select="p:consume(16, $input, $state)"/>       <!-- TILDE -->
          <xsl:variable name="state" select="p:parse-combinator-3($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:parse-combinator-4($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'combinator', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse negation_arg.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-negation_arg" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 27">                                       <!-- '|' -->
          <xsl:variable name="state" select="p:lookahead2(6, $input, $state)"/>     <!-- IDENT | '*' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = (8,                                           (: IDENT :)
                                         20)">                                      <!-- '*' -->
          <xsl:variable name="state" select="p:lookahead2(8, $input, $state)"/>     <!-- S | ')' | '|' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:lk] = (872,                                   (: IDENT '|' :)
                                               884)">                               <!-- '*' '|' -->
                <xsl:variable name="state" select="p:lookahead3(6, $input, $state)"/> <!-- IDENT | '*' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 72                                            (: IDENT S :)
                     or $state[$p:lk] = 283                                           (: '|' IDENT :)
                     or $state[$p:lk] = 616                                           (: IDENT ')' :)
                     or $state[$p:lk] = 9064                                          (: IDENT '|' IDENT :)
                     or $state[$p:lk] = 9076">                                      <!-- '*' '|' IDENT -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-type_selector($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 12">                                        <!-- HASH -->
          <xsl:variable name="state" select="p:consume(12, $input, $state)"/>       <!-- HASH -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 22">                                        <!-- '.' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-class($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 25">                                        <!-- '[' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-attrib($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 23">                                        <!-- ':' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-pseudo($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-universal($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'negation_arg', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production negation (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-negation-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(14, $input, $state)"/>      <!-- S | IDENT | HASH | '*' | '.' | ':' | '[' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-negation-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 2nd loop of production negation (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-negation-2">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(3, $input, $state)"/>       <!-- S | ')' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-negation-2($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse negation.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-negation" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(17, $input, $state)"/>             <!-- NOT -->
    <xsl:variable name="state" select="p:parse-negation-1($input, $state)"/>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-negation_arg($input, $state)
    "/>
    <xsl:variable name="state" select="p:parse-negation-2($input, $state)"/>
    <xsl:variable name="state" select="p:consume(19, $input, $state)"/>             <!-- ')' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'negation', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 2nd loop of production expression (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-expression-2">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(13, $input, $state)"/>      <!-- S | IDENT | STRING | NUMBER | PLUS | DIMENSION | ')' | '-' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-expression-2($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

<!--~
 ! Parse the 1st loop of production expression (one or more). Use
 ! tail recursion for iteratively updating the lexer state.
 !
 ! @param $input the input string.
 ! @param $state lexer state, error indicator, and result.
 ! @return the updated state.
-->
<xsl:function name="p:parse-expression-1">
  <xsl:param name="input" as="xs:string"/>
  <xsl:param name="state" as="item()+"/>

  <xsl:choose>
    <xsl:when test="$state[$p:error]">
      <xsl:sequence select="$state"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="state" as="item()+">
        <xsl:choose>
          <xsl:when test="$state[$p:error]">
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:when test="$state[$p:l1] = 13">                                      <!-- PLUS -->
            <xsl:variable name="state" select="p:consume(13, $input, $state)"/>     <!-- PLUS -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:when test="$state[$p:l1] = 21">                                      <!-- '-' -->
            <xsl:variable name="state" select="p:consume(21, $input, $state)"/>     <!-- '-' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:when test="$state[$p:l1] = 18">                                      <!-- DIMENSION -->
            <xsl:variable name="state" select="p:consume(18, $input, $state)"/>     <!-- DIMENSION -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:when test="$state[$p:l1] = 11">                                      <!-- NUMBER -->
            <xsl:variable name="state" select="p:consume(11, $input, $state)"/>     <!-- NUMBER -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:when test="$state[$p:l1] = 9">                                       <!-- STRING -->
            <xsl:variable name="state" select="p:consume(9, $input, $state)"/>      <!-- STRING -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(8, $input, $state)"/>      <!-- IDENT -->
            <xsl:sequence select="$state"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="state" select="p:parse-expression-2($input, $state)"/>
      <xsl:choose>
        <xsl:when test="$state[$p:l1] = 19">                                        <!-- ')' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="p:parse-expression-1($input, $state)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:function>

  <!--~
   ! Parse expression.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-expression" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:parse-expression-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'expression', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production functional_pseudo (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-functional_pseudo-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(11, $input, $state)"/>      <!-- S | IDENT | STRING | NUMBER | PLUS | DIMENSION | '-' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-functional_pseudo-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse functional_pseudo.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-functional_pseudo" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(10, $input, $state)"/>             <!-- FUNCTION -->
    <xsl:variable name="state" select="p:parse-functional_pseudo-1($input, $state)"/>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-expression($input, $state)
    "/>
    <xsl:variable name="state" select="p:consume(19, $input, $state)"/>             <!-- ')' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'functional_pseudo', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse pseudo.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-pseudo" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(23, $input, $state)"/>             <!-- ':' -->
    <xsl:variable name="state" select="p:lookahead1(9, $input, $state)"/>           <!-- IDENT | FUNCTION | ':' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 23">                                        <!-- ':' -->
          <xsl:variable name="state" select="p:consume(23, $input, $state)"/>       <!-- ':' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(5, $input, $state)"/>           <!-- IDENT | FUNCTION -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 8">                                         <!-- IDENT -->
          <xsl:variable name="state" select="p:consume(8, $input, $state)"/>        <!-- IDENT -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-functional_pseudo($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'pseudo', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production attrib (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-attrib-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(10, $input, $state)"/>      <!-- S | IDENT | '*' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-attrib-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 2nd loop of production attrib (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-attrib-2">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(12, $input, $state)"/>      <!-- S | INCLUDES | DASHMATCH | PREFIXMATCH | SUFFIXMATCH | SUBSTRINGMATCH |
                                                                                         '=' | ']' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-attrib-2($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 3rd loop of production attrib (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-attrib-3">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(7, $input, $state)"/>       <!-- S | IDENT | STRING -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-attrib-3($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 4th loop of production attrib (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-attrib-4">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(4, $input, $state)"/>       <!-- S | ']' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-attrib-4($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse attrib.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-attrib" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(25, $input, $state)"/>             <!-- '[' -->
    <xsl:variable name="state" select="p:parse-attrib-1($input, $state)"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 8">                                        <!-- IDENT -->
          <xsl:variable name="state" select="p:lookahead2(16, $input, $state)"/>    <!-- S | INCLUDES | DASHMATCH | PREFIXMATCH | SUFFIXMATCH | SUBSTRINGMATCH |
                                                                                         '=' | ']' | '|' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 20                                            (: '*' :)
                     or $state[$p:lk] = 27                                            (: '|' :)
                     or $state[$p:lk] = 872">                                       <!-- IDENT '|' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-namespace_prefix($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- IDENT -->
    <xsl:variable name="state" select="p:consume(8, $input, $state)"/>              <!-- IDENT -->
    <xsl:variable name="state" select="p:parse-attrib-2($input, $state)"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] != 26">                                       <!-- ']' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 5">                                   <!-- PREFIXMATCH -->
                <xsl:variable name="state" select="p:consume(5, $input, $state)"/>  <!-- PREFIXMATCH -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 6">                                   <!-- SUFFIXMATCH -->
                <xsl:variable name="state" select="p:consume(6, $input, $state)"/>  <!-- SUFFIXMATCH -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 7">                                   <!-- SUBSTRINGMATCH -->
                <xsl:variable name="state" select="p:consume(7, $input, $state)"/>  <!-- SUBSTRINGMATCH -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 24">                                  <!-- '=' -->
                <xsl:variable name="state" select="p:consume(24, $input, $state)"/> <!-- '=' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 3">                                   <!-- INCLUDES -->
                <xsl:variable name="state" select="p:consume(3, $input, $state)"/>  <!-- INCLUDES -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="p:consume(4, $input, $state)"/>  <!-- DASHMATCH -->
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="state" select="p:parse-attrib-3($input, $state)"/>
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 8">                                   <!-- IDENT -->
                <xsl:variable name="state" select="p:consume(8, $input, $state)"/>  <!-- IDENT -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="p:consume(9, $input, $state)"/>  <!-- STRING -->
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="state" select="p:parse-attrib-4($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:consume(26, $input, $state)"/>             <!-- ']' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'attrib', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse class.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-class" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:consume(22, $input, $state)"/>             <!-- '.' -->
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- IDENT -->
    <xsl:variable name="state" select="p:consume(8, $input, $state)"/>              <!-- IDENT -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'class', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse universal.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-universal" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 20">                                       <!-- '*' -->
          <xsl:variable name="state" select="p:lookahead2(20, $input, $state)"/>    <!-- END | S | HASH | PLUS | GREATER | COMMA | TILDE | NOT | ')' | '.' |
                                                                                         ':' | '[' | '|' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 8                                             (: IDENT :)
                     or $state[$p:lk] = 27                                            (: '|' :)
                     or $state[$p:lk] = 884">                                       <!-- '*' '|' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-namespace_prefix($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(1, $input, $state)"/>           <!-- '*' -->
    <xsl:variable name="state" select="p:consume(20, $input, $state)"/>             <!-- '*' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'universal', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse element_name.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-element_name" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(0, $input, $state)"/>           <!-- IDENT -->
    <xsl:variable name="state" select="p:consume(8, $input, $state)"/>              <!-- IDENT -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'element_name', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse namespace_prefix.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-namespace_prefix" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] != 27">                                       <!-- '|' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = 8">                                   <!-- IDENT -->
                <xsl:variable name="state" select="p:consume(8, $input, $state)"/>  <!-- IDENT -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="p:consume(20, $input, $state)"/> <!-- '*' -->
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="p:lookahead1(2, $input, $state)"/>           <!-- '|' -->
    <xsl:variable name="state" select="p:consume(27, $input, $state)"/>             <!-- '|' -->
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'namespace_prefix', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse type_selector.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-type_selector" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:l1] eq 8">                                        <!-- IDENT -->
          <xsl:variable name="state" select="p:lookahead2(20, $input, $state)"/>    <!-- END | S | HASH | PLUS | GREATER | COMMA | TILDE | NOT | ')' | '.' |
                                                                                         ':' | '[' | '|' -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:lk] = 20                                            (: '*' :)
                     or $state[$p:lk] = 27                                            (: '|' :)
                     or $state[$p:lk] = 872">                                       <!-- IDENT '|' -->
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-namespace_prefix($input, $state)
          "/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-element_name($input, $state)
    "/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'type_selector', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production simple_selector_sequence (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-simple_selector_sequence-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(18, $input, $state)"/>      <!-- END | S | HASH | PLUS | GREATER | COMMA | TILDE | NOT | '.' | ':' |
                                                                                         '[' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 12                                         (: HASH :)
                      and $state[$p:l1] != 17                                         (: NOT :)
                      and $state[$p:l1] != 22                                         (: '.' :)
                      and $state[$p:l1] != 23                                         (: ':' :)
                      and $state[$p:l1] != 25">                                     <!-- '[' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" as="item()+">
              <xsl:choose>
                <xsl:when test="$state[$p:error]">
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 12">                                <!-- HASH -->
                  <xsl:variable name="state" select="p:consume(12, $input, $state)"/> <!-- HASH -->
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 22">                                <!-- '.' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-class($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 25">                                <!-- '[' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-attrib($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:when test="$state[$p:l1] = 23">                                <!-- ':' -->
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-pseudo($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="state" select="
                    if ($state[$p:error]) then
                      $state
                    else
                      p:parse-negation($input, $state)
                  "/>
                  <xsl:sequence select="$state"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="p:parse-simple_selector_sequence-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse the 2nd loop of production simple_selector_sequence (one or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-simple_selector_sequence-2">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" as="item()+">
          <xsl:choose>
            <xsl:when test="$state[$p:error]">
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:when test="$state[$p:l1] = 12">                                    <!-- HASH -->
              <xsl:variable name="state" select="p:consume(12, $input, $state)"/>   <!-- HASH -->
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:when test="$state[$p:l1] = 22">                                    <!-- '.' -->
              <xsl:variable name="state" select="
                if ($state[$p:error]) then
                  $state
                else
                  p:parse-class($input, $state)
              "/>
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:when test="$state[$p:l1] = 25">                                    <!-- '[' -->
              <xsl:variable name="state" select="
                if ($state[$p:error]) then
                  $state
                else
                  p:parse-attrib($input, $state)
              "/>
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:when test="$state[$p:l1] = 23">                                    <!-- ':' -->
              <xsl:variable name="state" select="
                if ($state[$p:error]) then
                  $state
                else
                  p:parse-pseudo($input, $state)
              "/>
              <xsl:sequence select="$state"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:variable name="state" select="
                if ($state[$p:error]) then
                  $state
                else
                  p:parse-negation($input, $state)
              "/>
              <xsl:sequence select="$state"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="state" select="p:lookahead1(18, $input, $state)"/>      <!-- END | S | HASH | PLUS | GREATER | COMMA | TILDE | NOT | '.' | ':' |
                                                                                         '[' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 12                                         (: HASH :)
                      and $state[$p:l1] != 17                                         (: NOT :)
                      and $state[$p:l1] != 22                                         (: '.' :)
                      and $state[$p:l1] != 23                                         (: ':' :)
                      and $state[$p:l1] != 25">                                     <!-- '[' -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="p:parse-simple_selector_sequence-2($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse simple_selector_sequence.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-simple_selector_sequence" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="p:lookahead1(15, $input, $state)"/>          <!-- IDENT | HASH | NOT | '*' | '.' | ':' | '[' | '|' -->
    <xsl:variable name="state" as="item()+">
      <xsl:choose>
        <xsl:when test="$state[$p:error]">
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:when test="$state[$p:l1] = 8                                             (: IDENT :)
                     or $state[$p:l1] = 20                                            (: '*' :)
                     or $state[$p:l1] = 27">                                        <!-- '|' -->
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:l1] eq 27">                                 <!-- '|' -->
                <xsl:variable name="state" select="p:lookahead2(6, $input, $state)"/> <!-- IDENT | '*' -->
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:l1] = (8,                                     (: IDENT :)
                                               20)">                                <!-- '*' -->
                <xsl:variable name="state" select="p:lookahead2(19, $input, $state)"/> <!-- END | S | HASH | PLUS | GREATER | COMMA | TILDE | NOT | '.' | ':' |
                                                                                            '[' | '|' -->
                <xsl:variable name="state" as="item()+">
                  <xsl:choose>
                    <xsl:when test="$state[$p:lk] = (872,                             (: IDENT '|' :)
                                                     884)">                         <!-- '*' '|' -->
                      <xsl:variable name="state" select="p:lookahead3(6, $input, $state)"/> <!-- IDENT | '*' -->
                      <xsl:sequence select="$state"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:sequence select="$state"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$state[$p:l1], subsequence($state, $p:lk + 1)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="state" as="item()+">
            <xsl:choose>
              <xsl:when test="$state[$p:error]">
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:when test="$state[$p:lk] = 40                                      (: IDENT END :)
                           or $state[$p:lk] = 72                                      (: IDENT S :)
                           or $state[$p:lk] = 283                                     (: '|' IDENT :)
                           or $state[$p:lk] = 392                                     (: IDENT HASH :)
                           or $state[$p:lk] = 424                                     (: IDENT PLUS :)
                           or $state[$p:lk] = 456                                     (: IDENT GREATER :)
                           or $state[$p:lk] = 488                                     (: IDENT COMMA :)
                           or $state[$p:lk] = 520                                     (: IDENT TILDE :)
                           or $state[$p:lk] = 552                                     (: IDENT NOT :)
                           or $state[$p:lk] = 712                                     (: IDENT '.' :)
                           or $state[$p:lk] = 744                                     (: IDENT ':' :)
                           or $state[$p:lk] = 808                                     (: IDENT '[' :)
                           or $state[$p:lk] = 9064                                    (: IDENT '|' IDENT :)
                           or $state[$p:lk] = 9076">                                <!-- '*' '|' IDENT -->
                <xsl:variable name="state" select="
                  if ($state[$p:error]) then
                    $state
                  else
                    p:parse-type_selector($input, $state)
                "/>
                <xsl:sequence select="$state"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="state" select="
                  if ($state[$p:error]) then
                    $state
                  else
                    p:parse-universal($input, $state)
                "/>
                <xsl:sequence select="$state"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="state" select="p:parse-simple_selector_sequence-1($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:parse-simple_selector_sequence-2($input, $state)"/>
          <xsl:sequence select="$state"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'simple_selector_sequence', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 1st loop of production selector (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-selector-1">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$state[$p:l1] = 1                                           (: END :)
                       or $state[$p:l1] = 15">                                      <!-- COMMA -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="
              if ($state[$p:error]) then
                $state
              else
                p:parse-combinator($input, $state)
            "/>
            <xsl:variable name="state" select="
              if ($state[$p:error]) then
                $state
              else
                p:parse-simple_selector_sequence($input, $state)
            "/>
            <xsl:sequence select="p:parse-selector-1($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Parse selector.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-selector" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-simple_selector_sequence($input, $state)
    "/>
    <xsl:variable name="state" select="p:parse-selector-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'selector', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Parse the 2nd loop of production selectors_group (zero or more). Use
   ! tail recursion for iteratively updating the lexer state.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-selectors_group-2">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="state" select="p:lookahead1(17, $input, $state)"/>      <!-- S | IDENT | HASH | NOT | '*' | '.' | ':' | '[' | '|' -->
        <xsl:choose>
          <xsl:when test="$state[$p:l1] != 2">                                      <!-- S -->
            <xsl:sequence select="$state"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="state" select="p:consume(2, $input, $state)"/>      <!-- S -->
            <xsl:sequence select="p:parse-selectors_group-2($input, $state)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

<!--~
 ! Parse the 1st loop of production selectors_group (zero or more). Use
 ! tail recursion for iteratively updating the lexer state.
 !
 ! @param $input the input string.
 ! @param $state lexer state, error indicator, and result.
 ! @return the updated state.
-->
<xsl:function name="p:parse-selectors_group-1">
  <xsl:param name="input" as="xs:string"/>
  <xsl:param name="state" as="item()+"/>

  <xsl:choose>
    <xsl:when test="$state[$p:error]">
      <xsl:sequence select="$state"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$state[$p:l1] != 15">                                       <!-- COMMA -->
          <xsl:sequence select="$state"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="state" select="p:consume(15, $input, $state)"/>       <!-- COMMA -->
          <xsl:variable name="state" select="p:parse-selectors_group-2($input, $state)"/>
          <xsl:variable name="state" select="
            if ($state[$p:error]) then
              $state
            else
              p:parse-selector($input, $state)
          "/>
          <xsl:sequence select="p:parse-selectors_group-1($input, $state)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:function>

  <!--~
   ! Parse selectors_group.
   !
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:parse-selectors_group" as="item()+">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="count" select="count($state)"/>
    <xsl:variable name="begin" select="$state[$p:e0]"/>
    <xsl:variable name="state" select="
      if ($state[$p:error]) then
        $state
      else
        p:parse-selector($input, $state)
    "/>
    <xsl:variable name="state" select="p:parse-selectors_group-1($input, $state)"/>
    <xsl:variable name="end" select="$state[$p:e0]"/>
    <xsl:sequence select="p:reduce($state, 'selectors_group', $count, $begin, $end)"/>
  </xsl:function>

  <!--~
   ! Create a textual error message from a parsing error.
   !
   ! @param $input the input string.
   ! @param $error the parsing error descriptor.
   ! @return the error message.
  -->
  <xsl:function name="p:error-message" as="xs:string">
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="error" as="element(error)"/>

    <xsl:variable name="begin" select="xs:integer($error/@b)"/>
    <xsl:variable name="context" select="string-to-codepoints(substring($input, 1, $begin - 1))"/>
    <xsl:variable name="linefeeds" select="index-of($context, 10)"/>
    <xsl:variable name="line" select="count($linefeeds) + 1"/>
    <xsl:variable name="column" select="($begin - $linefeeds[last()], $begin)[1]"/>
    <xsl:variable name="expected" select="if ($error/@x or $error/@ambiguous-input) then () else p:expected-token-set($error/@s)"/>
    <xsl:sequence select="
      string-join
      (
        (
          if ($error/@o) then
            ('syntax error, found ', $p:TOKEN[$error/@o + 1])
          else
            'lexical analysis failed',
          '&#10;',
          'while expecting ',
          if ($error/@x) then
            $p:TOKEN[$error/@x + 1]
          else
          (
            '['[exists($expected[2])],
            string-join($expected, ', '),
            ']'[exists($expected[2])]
          ),
          '&#10;',
          if ($error/@o or $error/@e = $begin) then
            ()
          else
            ('after successfully scanning ', string($error/@e - $begin), ' characters beginning '),
          'at line ', string($line), ', column ', string($column), ':&#10;',
          '...', substring($input, $begin, 64), '...'
        ),
        ''
      )
    "/>
  </xsl:function>

  <!--~
   ! Consume one token, i.e. compare lookahead token 1 with expected
   ! token and in case of a match, shift lookahead tokens down such that
   ! l1 becomes the current token, and higher lookahead tokens move down.
   ! When lookahead token 1 does not match the expected token, raise an
   ! error by saving the expected token code in the error field of the
   ! lexer state.
   !
   ! @param $code the expected token.
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result.
   ! @return the updated state.
  -->
  <xsl:function name="p:consume" as="item()+">
    <xsl:param name="code" as="xs:integer"/>
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:error]">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:when test="$state[$p:l1] eq $code">
        <xsl:variable name="begin" select="$state[$p:e0]"/>
        <xsl:variable name="end" select="$state[$p:b1]"/>
        <xsl:variable name="whitespace">
          <xsl:if test="$begin ne $end">
            <xsl:value-of select="substring($input, $begin, $end - $begin)"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="token" select="$p:TOKEN[1 + $state[$p:l1]]"/>
        <xsl:variable name="name" select="if (starts-with($token, &quot;'&quot;)) then 'TOKEN' else $token"/>
        <xsl:variable name="begin" select="$state[$p:b1]"/>
        <xsl:variable name="end" select="$state[$p:e1]"/>
        <xsl:variable name="node">
          <xsl:element name="{$name}">
            <xsl:sequence select="substring($input, $begin, $end - $begin)"/>
          </xsl:element>
        </xsl:variable>
        <xsl:sequence select="
          subsequence($state, $p:l1, 9),
          0, 0, 0,
          subsequence($state, 13),
          $whitespace/node(),
          $node/node()
        "/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="error">
          <xsl:element name="error">
            <xsl:attribute name="b" select="$state[$p:b1]"/>
            <xsl:attribute name="e" select="$state[$p:e1]"/>
            <xsl:choose>
              <xsl:when test="$state[$p:l1] lt 0">
                <xsl:attribute name="s" select="- $state[$p:l1]"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="o" select="$state[$p:l1]"/>
                <xsl:attribute name="x" select="$code"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:element>
        </xsl:variable>
        <xsl:sequence select="
          subsequence($state, 1, $p:error - 1),
          $error/node(),
          subsequence($state, $p:error + 1)
        "/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Lookahead one token on level 1.
   !
   ! @param $set the code of the DFA entry state for the set of valid tokens.
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result stack.
   ! @return the updated state.
  -->
  <xsl:function name="p:lookahead1" as="item()+">
    <xsl:param name="set" as="xs:integer"/>
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:choose>
      <xsl:when test="$state[$p:l1] ne 0">
        <xsl:sequence select="$state"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="match" select="
          p:match($input, $state[$p:e0], $set),
          0, 0, 0
        "/>
        <xsl:sequence select="
          $match[1],
          subsequence($state, $p:b0, 2),
          $match,
          subsequence($state, 10)
        "/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <!--~
   ! Lookahead one token on level 2.
   !
   ! @param $set the code of the DFA entry state for the set of valid tokens.
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result stack.
   ! @return the updated state.
  -->
  <xsl:function name="p:lookahead2" as="item()+">
    <xsl:param name="set" as="xs:integer"/>
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="match" select="
      if ($state[$p:l2] ne 0) then
        subsequence($state, $p:l2, 6)
      else
      (
        p:match($input, $state[$p:e1], $set),
        0, 0, 0
      )
    "/>
    <xsl:sequence select="
      $match[1] * 32 + $state[$p:l1],
      subsequence($state, $p:b0, 5),
      $match,
      subsequence($state, 13)
    "/>
  </xsl:function>

  <!--~
   ! Lookahead one token on level 3.
   !
   ! @param $set the code of the DFA entry state for the set of valid tokens.
   ! @param $input the input string.
   ! @param $state lexer state, error indicator, and result stack.
   ! @return the updated state.
  -->
  <xsl:function name="p:lookahead3" as="item()+">
    <xsl:param name="set" as="xs:integer"/>
    <xsl:param name="input" as="xs:string"/>
    <xsl:param name="state" as="item()+"/>

    <xsl:variable name="match" select="
      if ($state[$p:l3] ne 0) then
        subsequence($state, $p:l3, 3)
      else
        p:match($input, $state[$p:e2], $set)
    "/>
    <xsl:sequence select="
      $match[1] * 1024 + $state[$p:lk],
      subsequence($state, $p:b0, 8),
      $match,
      subsequence($state, 13)
    "/>
  </xsl:function>

  <!--~
   ! Reduce the result stack, creating a nonterminal element. Pop
   ! $count elements off the stack, wrap them in a new element
   ! named $name, and push the new element.
   !
   ! @param $state lexer state, error indicator, and result.
   ! @param $name the name of the result node.
   ! @param $count the number of child nodes.
   ! @param $begin the input index where the nonterminal begins.
   ! @param $end the input index where the nonterminal ends.
   ! @return the updated state.
  -->
  <xsl:function name="p:reduce" as="item()+">
    <xsl:param name="state" as="item()+"/>
    <xsl:param name="name" as="xs:string"/>
    <xsl:param name="count" as="xs:integer"/>
    <xsl:param name="begin" as="xs:integer"/>
    <xsl:param name="end" as="xs:integer"/>

    <xsl:variable name="node">
      <xsl:element name="{$name}">
        <xsl:sequence select="subsequence($state, $count + 1)"/>
      </xsl:element>
    </xsl:variable>
    <xsl:sequence select="subsequence($state, 1, $count), $node/node()"/>
  </xsl:function>

  <!--~
   ! Parse start symbol selectors_group from given string.
   !
   ! @param $s the string to be parsed.
   ! @return the result as generated by parser actions.
  -->
  <xsl:function name="p:parse-selectors_group" as="item()*">
    <xsl:param name="s" as="xs:string"/>

    <xsl:variable name="state" select="0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, false()"/>
    <xsl:variable name="state" select="p:parse-selectors_group($s, $state)"/>
    <xsl:variable name="error" select="$state[$p:error]"/>
    <xsl:choose>
      <xsl:when test="$error">
        <xsl:variable name="ERROR">
          <xsl:element name="ERROR">
            <xsl:sequence select="$error/@*, p:error-message($s, $error)"/>
          </xsl:element>
        </xsl:variable>
        <xsl:sequence select="$ERROR/node()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="subsequence($state, $p:result)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

</xsl:stylesheet>