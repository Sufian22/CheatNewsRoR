module SubmissionsHelper
  
  
  #validate url 
  def extlink(link)
  if link.include?("http://") or link.include?("https://")
    return link
  else
    return link.insert(0,"http://")
  end  
  end
  
  def vote(id,dir)
  
  
  end  
end
