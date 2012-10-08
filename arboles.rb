# El primer nodo, imprimir su value. 
# por cada children
# Imprimir su value

class Node
  
  attr_accessor :children
  
  def initialize(expression)
    @expression = expression
    #
    # Scanear la expression por separadores.
    # -- Si encontramos, agruparla y quitar los separadores.
    look_for_separators unless @expression.nil?
  end
  
  def look_for_separators
    @r = @expression.match(regular)
    if @r.nil?
      decompose_expression
      end_children
    else      
      @c = [Node.new(@r[1]), Node.new(clean_separators)]
      decompose_expression
    end
  end
  
  def clean_separators
    @expression.gsub("(#{@r[1]})+", '')
  end
  
  def decompose_expression
    operadores.each do |o|
      @value = o unless @expression.scan(o).empty?
      return unless @value.nil?
    end
  end
  
  def regular
    /\(([^\"]*)\)/
  end
  
  # Tenemos que cambiar: El method: regular, pasarle los separadores
  # clean_separators 
  # look_for_separators tiene que loop for each separator
  
  def value    
    @value ? @value : @expression
  end
  
  def end_children
    exp = @expression.split(value)
    @c =  [Node.new(exp[0]), Node.new(exp[1])]
  end
  
  def children
    @c
  end
  
  def operadores
    ['=', '+', '-', '*', '/', '^']
  end
  
  def separadores
    ['{}', '[]', '()']
  end
end

