object DmCliente: TDmCliente
  OnCreate = DataModuleCreate
  Height = 388
  Width = 722
  object fdPesquisar: TFDQuery
    SQL.Strings = (
      'SELECT * FROM cliente WHERE nome ILIKE :nome ORDER BY nome')
    Left = 136
    Top = 96
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end>
  end
  object fdInserir: TFDQuery
    SQL.Strings = (
      'INSERT INTO cliente (nome, tipo, documento, telefone)'
      'VALUES (:nome, :tipo, :documento, :telefone)'
      'RETURNING id')
    Left = 240
    Top = 104
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TIPO'
        ParamType = ptInput
      end
      item
        Name = 'DOCUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'TELEFONE'
        ParamType = ptInput
      end>
  end
  object fdAlterar: TFDQuery
    SQL.Strings = (
      
        'UPDATE cliente SET nome=:nome, tipo=:tipo, documento=:documento,' +
        ' telefone=:telefone WHERE id=:id')
    Left = 360
    Top = 128
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        Name = 'TIPO'
        ParamType = ptInput
      end
      item
        Name = 'DOCUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'TELEFONE'
        ParamType = ptInput
      end
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
  object fdExcluir: TFDQuery
    SQL.Strings = (
      'DELETE FROM cliente WHERE id=:id')
    Left = 488
    Top = 144
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
end
