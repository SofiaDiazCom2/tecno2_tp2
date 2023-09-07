void contactStarted( FContact colision){
  
  if( hayColisionEntre( colision, "bala", "enemigo")){
    
  FBody uno = colision.getBody1();
  //FBody dos = colision.getBody2();
  
  //mundo.remove( dos );
  mundo.remove( uno );

  
  
  }
  
}
    
boolean hayColisionEntre(FContact contact, String nombreUno, String nombreDos ){
  
  boolean resultado = false;
  
  FBody uno = contact.getBody1();
  FBody dos = contact.getBody2();
  
  String etiquetaUno = uno.getName();
  String etiquetaDos = dos.getName();
    
    if (etiquetaUno != null && etiquetaDos != null){
      if(
      
      (nombreUno.equals( etiquetaUno ) && nombreDos.equals(etiquetaDos)) ||
      (nombreDos.equals(etiquetaUno) && nombreUno.equals(etiquetaDos))
      
      ){
        resultado = true;
      }
        
      }
      return resultado;
    }


void agregarEnemigo(){
 
  
  FBox enemigo = new FBox(40, 40);
  enemigo.setPosition(894, 184);
  enemigo.setStatic(true);
  enemigo.setName("enemigo");
  enemigo.setFill(150);
  mundo.add(enemigo);
  
}


void borrarBalas(){
  
  ArrayList <FBody> cuerpos = mundo.getBodies();
  
  for ( FBody este: cuerpos) {
    
    String nombre = este.getName();
    
    if( nombre != null){
      if(nombre.equals("bala")){
        if(este.getY() > height+100){
          mundo.remove(este);
        }
        
      }
    }
  }
}
