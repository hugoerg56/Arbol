require './arboles'

describe Node do 
  it "decomposes =" do
    node = Node.new("3=4")
    node.value.should == "="
    node.children.size.should ==  2
    
    node.children.first.value.should == "3"
    node.children.last.value.should == "4"
  end
  
  it "decomposes -" do
    node = Node.new("3-3")
    node.value.should == "-"
  end
  
  it "decompose (= & -)" do
    node = Node.new("4+2=6")
    node.value.should == "="
    node.children.first.value.should == "+"
    node.children.last.value.should == "6"
    
    t = node.children.first
    t.children.first.value.should == "4"
    t.children.last.value.should == "2"
  end  
  
  it "decompose multiple operators" do
    node = Node.new("33*1-A/6-4+2=6^34+2-B*G")
    node.value.should == "="
    
    node.children.first.children.first.children.first.children.first.value.should == "33"
    node.children.last.children.first.value == "^"
  end    
  
  it "decompose with separadores ()" do
    node = Node.new("(3+7)+5")
    # + 
    #- (3+7), 5
    # +  , -
    # 3, 7
     node.value.should == "+"
     node.children.first.value.should == "+"
     node.children.first.children.first.value.should == "3"     
     node.children.last.value.should == "5"
  end  
  
  it "decompose with separadores {}" do
    node = Node.new("{3+7}+5")
    
    node.value.should == "+"
    node.children.first.value.should == "+"
    node.children.first.children.first.value.should == "3"     
    node.children.last.value.should == "5"    
  end    
end
