# 在Windows上设置shell
set shell := ["powershell", "-c"]

# 生成PDF文件
watch:
    typst watch src/main.typ "480kw电源柜集成设计.pdf"

# 查看生成的PDF
pdf:
    SumatraPDF "480kw电源柜集成设计.pdf"
