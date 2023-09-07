FCircle crearEsferaRaw( float x, float y, float t, color c, float g, boolean e){
  
  FCircle main = new FCircle(t);
  main.setPosition( x, y );
  main.setVelocity( 0, 0 );
  main.setFillColor( c );
  main.setStatic( e );
  
  float r = (t/20) / 2;
  
  main.setDensity( g / (PI * r * r ));
  main.setNoStroke();
  
  return main;
}

FCircle crearEsfera( float x, float y, float t, color c){
  
  return crearEsferaRaw ( x, y, t, c, 10, true);
}
