object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'BDMG'
  ClientHeight = 398
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Conexao: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI11.1;Persist Security Info=False;User ID=sa;Init' +
      'ial Catalog=bdmg;Data Source=localhost\SQLEXPRESS;Use Procedure ' +
      'for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation I' +
      'D=RYZEN-7;Initial File Name="";Use Encryption for Data=False;Tag' +
      ' with column collation when possible=False;MARS Connection=False' +
      ';DataTypeCompatibility=0;Trust Server Certificate=False;Server S' +
      'PN="";Application Intent=READWRITE;'
    LoginPrompt = False
    Provider = 'SQLNCLI11.1'
    Left = 256
    Top = 144
  end
  object Imagens: TImageList
    Left = 256
    Top = 88
    Bitmap = {
      494C010108001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000031DE000031DE00000000004A637B00BD9494000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C6B63009C6B
      63009C6B63009C6B63009C6B63009C6B63009C6B63009C6B63009C6B63009C6B
      63009C6B63009C6B6300A56B6B0000000000000000000031DE000031DE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000031DE000031DE00000000006B9CC600188CE7004A7BA500C694
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C736B00FFE7
      C600F7DEB500F7D6AD00F7D69C00F7CE9400EFC68400EFC68400EFC68400EFC6
      8400EFC68400EFC684009C6B630000000000000000000031DE000031DE000031
      DE00000000000000000000000000000000000000000000000000000000000000
      00000031DE000031DE0000000000000000004AB5FF0052B5FF00218CEF004A7B
      A500C69494000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C736B00F7E7
      C600F7DEBD00F7D6AD00EFCEA500EFCE9C00EFC69400EFC68400EFBD7B00EFBD
      7B00EFBD7B00EFBD7B009C6B630000000000000000000031DE000031DE000031
      DE000031DE000000000000000000000000000000000000000000000000000031
      DE000031DE000000000000000000000000000000000052B5FF0052B5FF001884
      E7004A7BA500C694940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000993300009933
      0000993300000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C736B00F7E7
      D600FFEFCE00F7DEBD00FFDEB500F7D6AD00EFCE9C00EFC69400EFC68400EFBD
      7B00EFBD7B00EFBD7B009C6B63000000000000000000000000000031EF000031
      DE000031DE000031DE00000000000000000000000000000000000031DE000031
      DE0000000000000000000000000000000000000000000000000052B5FF004AB5
      FF00188CE7004A7BA500BD949400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000AA5F1F009933000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5737300FFF7
      DE00948C8C00948C8C00948C8C00948C8C00E7C69C00EFCE9C00EFC69400EFC6
      8400EFBD7B00EFBD7B009C6B6300000000000000000000000000000000000000
      00000031DE000031DE000031DE00000000000031DE000031DE000031DE000000
      00000000000000000000000000000000000000000000000000000000000052B5
      FF004AB5FF002184DE005A6B730000000000AD7B7300C6A59C00D6B5A500CEA5
      9C00000000000000000000000000000000000000000000000000000000000000
      000099330000BA7D480099330000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A57B7300FFFF
      F700313129006B7394001029A50021213900D6B58C00F7D6AD00EFCE9C00EFC6
      9400EFC68400EFBD7B009C6B6300000000000000000000000000000000000000
      0000000000000031DE000031E7000031E7000031E7000031DE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052BDFF00B5D6EF00A5948C00B59C8C00F7E7CE00FFFFD600FFFFD600FFFF
      D600E7DEBD00CEADA50000000000000000000000000000000000000000000000
      00000000000099330000CDA27C00D8B596009933000099330000000000000000
      0000000000000000000000000000000000000000000000000000AD847B00FFFF
      F70031313900637BE7007B94FF0010219C00DEC69C00FFDEB500EFCEA500EFCE
      9C00EFC69400EFC684009C6B6300000000000000000000000000000000000000
      000000000000000000000031E7000031E7000031EF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEB5B500D6B5A500FFEFC600FFFFD600FFFFD600FFFFD600FFFF
      DE00FFFFEF00F7F7EF00B58C8C00000000000000000000000000000000000000
      0000000000000000000099330000E1C6B000ECDCCD00EDDDD100993300000000
      0000000000000000000000000000000000000000000000000000B58C7B00FFFF
      FF0042424200524A4A005A524A00182994006373D600C6B59C00F7D6B500EFCE
      A500EFCE9C00EFC694009C6B6300000000000000000000000000000000000000
      0000000000000031DE000031EF000031E7000031EF000031F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6948C00F7DEB500F7D6A500FFF7CE00FFFFD600FFFFDE00FFFF
      EF00FFFFF700FFFFFF00DED6BD00000000000000000000000000000000000000
      000000000000000000000000000099330000F4E9E200FDF9F500FBF4EC009933
      0000993300000000000000000000000000000000000000000000BD8C7B00FFFF
      FF00FFFFFF00F7EFE700F7E7D600F7E7D600637BE700425AE700E7CEBD00F7D6
      AD00EFCEA500EFCE9C009C6B6300000000000000000000000000000000000000
      00000031F7000031EF000031E70000000000000000000031F7000031F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEBDA500FFE7AD00F7CE9400FFF7CE00FFFFDE00FFFFE700FFFF
      F700FFFFF700FFFFEF00F7EFD600C69C94000000000000000000000000000000
      000000000000000000000000000099330000E1C0AB00F7E9DA00F4E0CC00E1BA
      9C00993300009933000000000000000000000000000000000000C6947B00FFFF
      FF00948C8C00948C8C00948C8C00948C8C00EFE7CE00C6BDDE00EFD6C600F7D6
      B500F7D6AD00E7C69C0094736B00000000000000000000000000000000000031
      FF000031EF000031F700000000000000000000000000000000000031FF000031
      F700000000000000000000000000000000000000000000000000000000000000
      000000000000E7C6AD00FFDEAD00EFBD8400F7E7B500FFFFD600FFFFDE00FFFF
      E700FFFFE700FFFFDE00F7F7D600C6AD9C000000000000000000000000000000
      0000000000000000000099330000F6E6D600F3DEC800F0D5BA00E3B995009933
      0000000000000000000000000000000000000000000000000000CE9C8400FFFF
      FF0031312900A5A5A5005263AD0029314200D6CEBD00FFF7DE00FFEFCE00F7E7
      C600DECEAD00B5A58C00846B63000000000000000000000000000031F7000031
      F7000031FF000000000000000000000000000000000000000000000000000031
      F7000031F7000000000000000000000000000000000000000000000000000000
      000000000000DEBDAD00FFE7B500EFBD8400F7CE9400FFEFC600FFFFDE00FFFF
      DE00FFFFDE00FFFFDE00F7EFD600C6A59C000000000000000000000000000000
      000000000000000000000000000099330000EDCAA800EAC19900E7B98B00DFA8
      7500993300000000000000000000000000000000000000000000CE9C8400FFFF
      FF0042424A007B94FF00426BFF0018297B00E7DEC600FFF7E700E7CEBD00A56B
      6B00A56B6B00A56B6B00A56B6B0000000000000000000031F7000031F7000031
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000031F70000000000000000000000000000000000000000000000
      000000000000C69C9400FFEFC600FFEFC600F7D6A500F7CE9C00F7E7B500FFF7
      CE00FFF7D600FFFFD600E7DEBD00000000000000000000000000000000000000
      00000000000000000000000000000000000099330000E3AE7900E0A56B00DD9C
      5C00DA944F009933000000000000000000000000000000000000D6A58400FFFF
      FF0029292900636B84008C8C9C000821A500BDC6F700FFFFF700D6B5AD00A56B
      6B00E79C4A00E78C3100A56B6B00000000000031F7000031F7000031F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEC6AD00FFFFFF00FFF7EF00F7CE9400EFBD8400F7CE
      9C00FFE7B500FFF7C600BD9C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000993300009933
      0000993300009933000099330000000000000000000000000000D6A58400FFFF
      FF00ADB5B50094949400949494008C9CC6004263FF009CB5FF00D6B5BD00A56B
      6B00F7AD5A00A56B6B0000000000000000000031F7000031F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6BDBD00F7EFD600FFEFC600FFE7AD00FFE7
      B500F7DEB500CEAD9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6A58400F7EF
      E700FFFFF700FFFFF700FFFFF700FFF7EF00CECEEF005A73EF00B5A5B500A56B
      6B00A56B6B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CEAD9400CEAD9C00DEBDA500DEBD
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6946B00D69C
      7B00D69C7B00D69C7B00CE947300C68C7300C68C7300C68C7300AD736B00A56B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AD5A5A00AD52
      5200A54A4A00AD949400C6CEC600CECEC600CECEC600C6CEC600C6CEC600B59C
      9C009C4242009C424200A5525200000000000000000000000000000000000000
      000000000000000000000000000008780E0008780E0000000000000000000000
      000000000000000000000000000000000000B7818300B7818300B7818300B781
      8300B7818300B7818300B7818300B7818300B7818300B7818300B7818300B781
      8300B78183000000000000000000000000000000000000000000000000000000
      0000F5CA9900F6D1A100F5CB9900F3C18B00F2C08800F3C38E00000000000000
      00000000000000000000000000000000000000000000BD7B7300CE636300CE6B
      6B00B55A5A009C848400BDA5A500E7CECE00FFF7F700FFFFF700F7F7F700CEB5
      B500942929009C313100C65A5A00AD5A5A000000000000000000000000000000
      0000000000000000000008780E0076F9A7000DA31B0008780E00000000000000
      000000000000000000000000000000000000B7818300FDEFD900F4E1C900E4CF
      B400D1BCA000CDB79800DAC09A00E4C59900E9C89600EDCB9600EECC9700F3D1
      9900B7818300000000000000000000000000000000000000000000000000FCF0
      CC00FEF6D500FCE6BE00F6D5A600FCC69600FFC49500FDD6AE00FFE2BF00FEE2
      BA00F4C5900000000000000000000000000000000000BD7B7300CE636300CE63
      6300B55A5A009C7B7B009C424200B5737300E7DEDE00FFF7F700FFFFFF00D6B5
      B500943131009C313100BD5A5A00AD5A5A000000000000000000000000000000
      0000000000000000000008780E0076F9A7000EAA1D0008780E00000000000000
      000000000000000000000000000000000000B4817600FEF3E300F8E7D3004946
      4500373C3E0051606100AE9C8200BFA88900D0B48D00E4C39300EDCB9600F3D1
      9900B7818300000000000000000000000000000000000000000000000000FEFB
      DD00FEF9D800FCE4BB00F0D6A700BBC888009CBD6F0043A7360072BA5E00EFF6
      D400FDEECC00F2BF8900000000000000000000000000BD7B7300CE636300CE63
      6300B55A5A00AD8484009C3939009C393900CEBDBD00EFEFEF00FFFFFF00E7C6
      C6009429290094313100BD5A5A00AD5A5A000000000000000000000000000000
      0000000000000000000008780E0076F9A7000EA81C0008780E00000000000000
      000000000000000000000000000000000000B4817600FFF7EB00F9EBDA00B0A5
      98001B617D00097CA80018556F0066625B00A7947900C5AC8600DCBD8D00EECD
      9500B78183000000000000000000000000000000000000000000F1B87F00F6D0
      A100FDF4D100FDEBC500FCDBB30044AB3800009402000E9A0F0010970B0057B6
      4E00FEF5DB00F4C28C00000000000000000000000000BD7B7300CE636300CE63
      6300B55A5A00B58C8C009C4A4A0094313100A59C9C00D6D6D600FFFFFF00E7C6
      C6009429290094313100BD5A5A00AD5A5A000000000000000000000000000000
      0000000000000000000008780E0076F9A70010AA1F0008780E00000000000000
      000000000000000000000000000000000000BA8E8500FFFCF400FAEFE400F2E5
      D6003872860029799A008D787F00956D6F00795953009D8B7300BAA38000D9BC
      8C00B47F81000000000000000000000000000000000000000000F2BD8700F1BA
      8100F3C18A00F8D5A600FFE1BE0047AD3A000088000084CD8500FFF4EF0063B5
      5200B6C07900FDC08D00000000000000000000000000BD7B7300CE636300CE63
      6300BD5A5A00C6948C00C6949400B5848400AD8C8C00BDA5A500E7C6C600DEAD
      AD00A5393900A5393900C65A5A00AD5A5A00000000000000000008780E000878
      0E0008780E0008780E0008780E0076F9A70019B02C0008780E0008780E000878
      0E0008780E0008780E000000000000000000BA8E8500FFFFFD00FBF4EC00FAEF
      E300A5B3B1007C707800E5A6A300C8929200A47272007657510095856C00AF99
      7800A87779000000000000000000000000000000000000000000F5C49200F5C7
      9600F4C39000F4BE8900FCC5960093C47B005CB95C0089CB8300FFFFFF00F7FE
      FC00CBCA9200F6BC8500000000000000000000000000BD7B7300CE636300CE63
      6300CE636300CE636300CE636300CE636300CE636300C65A5A00C65A5A00CE63
      6300CE636300CE636300CE6B6B00AD525A000000000008780E0076F9A70055E3
      830049DA720042D3680037C856002AB9430022B337001CB2300016AF27000FA8
      1D000EA91B000DA21B0008780E0000000000CB9A8200FFFFFF00FEF9F500FBF3
      EC00F4EBDF0085787C00EEB7B500DAA6A600C38E8E009E6E6E0073564F009383
      6B00996E6F000000000000000000000000000000000000000000F9D0A800FBD2
      AD00FAD0A900FACEA600F6CDA100D0DFB800FFFFFF00E2F2DF0071C26E0066C0
      6600C8CB9200FAC18E00000000000000000000000000BD7B7300B5525200B55A
      5A00C6848400D6A5A500D6ADAD00D6ADA500D6ADAD00D6A5A500D6A5A500D6AD
      A500D6ADAD00D69C9C00CE636300AD5252000000000008780E0076F9A70076F9
      A70076F9A70076F9A70076F9A70076F9A7002CBB480076F9A70076F9A70076F9
      A70076F9A70076F9A70008780E0000000000CB9A8200FFFFFF00FFFEFD00FDF8
      F400FBF3EC00F0E4D900A3797800E9B5B500D9A5A500C48F8F009D6D6D007759
      52008F67690000000000000000000000000000000000F8D4A800FDDEBF00FDDE
      BE00FDDBBB00FDDBBB00FFDEC50078BB610098D49800E7F5E6003EAD3B00008A
      00009AC17600FFCCA600F2BE87000000000000000000BD7B7300AD524A00E7CE
      CE00F7F7F700F7F7EF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700DEBDBD00C65A5A00AD525A00000000000000000008780E000878
      0E0008780E0008780E0008780E0076F9A7003CCB5D0008780E0008780E000878
      0E0008780E0008780E000000000000000000DCA88700FFFFFF00FFFFFF00FFFE
      FD00FEF9F400FBF3EB00E8D9CE009E747300E8B5B500D8A4A400C18D8D009D6C
      6C007D55560000000000000000000000000000000000F8D4A800FFEFD100FEEA
      CB00FEE9C900FEE7C800FFE7C900E2E2BE00169A14002BA12900089708000092
      000090C47800FFD9BC00F2BE87000000000000000000BD7B7300B5524A00EFD6
      D600FFF7F700F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EF
      EF00F7F7F700DEBDBD00C65A5A00AD525A000000000000000000000000000000
      0000000000000000000008780E0076F9A70049D9720008780E00000000000000
      000000000000000000000000000000000000DCA88700FFFFFF00FFFFFF00FFFF
      FF00FFFEFD00FDF9F400FBF3EB00E0CFC500A1767600ECB9B900D6A2A200C68E
      8E00965F5D00585C6000000000000000000000000000FBE5BD00FFFCDF00FFF7
      D800FFF6D600FFF4D500FFF3D200FFF5DC00C5DFAD0042AB3B0043AE3B00AFD7
      9E00C5DCAA00FFE7C900F5C793000000000000000000BD7B7300B5524A00EFD6
      D600EFEFEF00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600EFEFEF00DEBDBD00C65A5A00AD525A000000000000000000000000000000
      0000000000000000000008780E0076F9A70055E2820008780E00000000000000
      000000000000000000000000000000000000E3B18E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFEFD00FDF8F300FDF6EC00DAC5BC00AC808000F3BCBB00A387
      8C003392B30019ADCC0019ADCC000000000000000000FDF3D100FFFFE100FFFC
      DD00FFFDDE00FFFCDD00FFFCDE00FFFDDE00FFFFE800FFFFF000FFFFED00FFFF
      E700FFFAE000FFF7D700F6CE9D000000000000000000BD7B7300B5524A00EFD6
      D600EFEFEF00DED6D600DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DED6
      D600EFEFEF00DEBDBD00C65A5A00AD525A000000000000000000000000000000
      0000000000000000000008780E0076F9A70063F0970008780E00000000000000
      000000000000000000000000000000000000E3B18E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFEFC00FFFEF900E3CFC900AA7A7100B2787300469C
      BA000FCAF40000A4E600021EAA000000990000000000FEF7D700FFFFE500FFFF
      E200FFFFE200FFFFE300FFFEE000FEF8D800FAE3B600F7CE9500F7CF9700F9E1
      B600FEF5D200FFFFE500F6D5A7000000000000000000BD7B7300B5524A00EFD6
      D600F7F7EF00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00EFEFEF00DEBDBD00C65A5A00AD525A000000000000000000000000000000
      0000000000000000000008780E0076F9A70076F9A70008780E00000000000000
      000000000000000000000000000000000000EDBD9200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4D4D200B8857A00DCA76A0010A5
      CF0004A8E6000936C900092CC3000318AE0000000000F7D8AB00FAE6C000FAE5
      BE00F9E1B900F8DAAE00F6CD9800F3BE8000F0B16A00F0B06700F0B37000F4BE
      8800FBCE9E00FDDDB400FBCEA0000000000000000000BD7B7300B5524A00EFD6
      D600EFEFEF00D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600EFEFEF00DEBDBD00C65A5A00AD525A000000000000000000000000000000
      000000000000000000000000000008780E0008780E0000000000000000000000
      000000000000000000000000000000000000EDBD9200FCF7F400FCF7F300FBF6
      F300FBF6F300FAF5F300F9F5F300F9F5F300E1D0CE00B8857A00CF9B86000000
      0000077DCD004860F100204ADD000416AA000000000000000000000000000000
      00000000000000000000000000000000000000000000F1B66F00F3BD8200F9CB
      9B00FBCD9F00FBCB9B00FBCB9B000000000000000000BD7B7300B5524A00E7D6
      CE00FFF7F700F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EF
      EF00FFF7F700DEBDBD00C65A5A00AD525A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EDBD9200DCA88700DCA88700DCA8
      8700DCA88700DCA88700DCA88700DCA88700DCA88700B8857A00000000000000
      0000000000003E4BDB00192DC400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBCE
      9F00FBCE9F00FBCE9F0000000000000000000000000000000000AD524A00CEB5
      B500D6D6D600CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECE
      CE00D6D6D600CEADAD00A54A4A0000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFC9FFFFFFFC0019FF90FFF7FFFC001
      8FF307FF9FFFC00187E783FFC7FFC001C3CFC1FFE3FFC001F11FE10FF0FFC001
      F83FF003F83FC001FC7FF801FC1FC001F83FF801FE07C001F19FF800FE03C001
      E3CFF800FC0FC001C7E7F800FE07C0018FFBF801FF03C0011FFFFC01FF81C003
      3FFFFE03FFFFC007FFFFFF0FFFFFC00FFFFFFFFFFFFFC001FE7F0007F03F8000
      FC3F0007E0078000FC3F0007E0038000FC3F0007C0038000FC3F0007C0038000
      C0030007C003800080010007C00380008001000780018000C003000780018000
      FC3F000380018000FC3F000180018000FC3F000080018000FC3F000080018000
      FE7F0010FF818000FFFF0039FFE3C00100000000000000000000000000000000
      000000000000}
  end
  object MainMenu: TMainMenu
    Left = 256
    Top = 200
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Cliente1: TMenuItem
        Caption = 'Cliente'
        OnClick = Cliente1Click
      end
      object Cliente2: TMenuItem
        Caption = 'Fornecedor'
        OnClick = Cliente2Click
      end
      object Produto1: TMenuItem
        Caption = 'Produto'
        OnClick = Produto1Click
      end
    end
    object Venda1: TMenuItem
      Caption = 'Venda'
      OnClick = Venda1Click
    end
    object Venda2: TMenuItem
      Caption = 'Relat'#243'rios'
      OnClick = Venda2Click
    end
  end
end