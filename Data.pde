//DATA////

void processData(){
    //Record the readings in an array for the duration of the graph     
    //add data to the 5 'reading' arrays
     touchData0.append(int(sensor0)); 
     touchData1.append(int(sensor1)); 
     touchData2.append(int(sensor2)); 
     touchData3.append(int(sensor3)); 
     touchData4.append(int(sensor4)); 
}

void addNewDataArrays() {
  tuftAreas = new IntList[5];
  tuftAreas[0] = touchData0;
  tuftAreas[1] = touchData1;
  tuftAreas[2] = touchData2;
  tuftAreas[3] = touchData3;
  tuftAreas[4] = touchData4;
  
  ArrayList<ArrayList<Integer>> newDataArrays = new ArrayList<ArrayList<Integer>>();
  for (int i = 0; i < tuftAreas.length; i++) {
    ArrayList<Integer> newArray = new ArrayList<Integer>();
    //Random rand = new Random();
    for (int j = 0; j < tuftAreas[0].size(); j++) {
      //newArray.add(rand.nextInt(360)); // generating random numbers between 0 and 360
      newArray.add(tuftAreas[i].get(j)); // add each item in each element
    }
    newDataArrays.add(newArray);
  }
  allDataArrays.add(newDataArrays);
}

void addColors() {
  //for (int i = 0; i < arraySize; i++) {
    //colors.add(color(random(360),100, 100,50));//HSB+alpha
    //HSB=alpha
    colors.add(color(35,100,90,100));//Orange
    colors.add(color(347,100,80,100));//red
    colors.add(color(177,100,50,100)); //blue
    colors.add(color(70,100,80,100)); //lime
    colors.add(color(316,70,80,100)); //pink
    
    //println(colors.get(0));
  //}
}

void displayGraphs() {
  clear();

  for (int k = 0; k < allDataArrays.size(); k++) { //How many readings
    ArrayList<ArrayList<Integer>> dataArrays = allDataArrays.get(k);
    for (int i = 0; i < dataArrays.size(); i++) { //size of reading (5 for TT)
      
      ArrayList<Integer> data = dataArrays.get(i);
      stroke(colors.get(i));
      int yStagger = i*(height/5);//spread evenly across the height of screen
      float xSpacing = (float)width / data.size(); //distance between each data item

      for (int j = 0; j < data.size() - 1; j++) { //How many items in each element
        float x1 = j * xSpacing;
        float y1 = map(data.get(j), 0, 360, height - graphHeight, height);
        float x2 = (j + 1) * xSpacing;
        //float y2 = map(data.get(j + 1), 0, 1000, height - graphHeight, height);
        float y2 = map(data.get(j + 1), 0, 360, height - graphHeight, height);

          line(x1, y1-yStagger, x2, y2-yStagger);
          //rect(x1, y1-yStagger, x2, y2-yStagger);

      }
    }
  }
  noLoop();
}

boolean previousDataExists() {
  File file = new File(sketchPath(dataFilePath));
  return file.exists() && file.length() > 0;
}

void loadDataArrays() {
  JSONObject jsonData = loadJSONObject(dataFilePath);
  
  for (int i = 0; i < jsonData.size(); i++) {
    JSONArray jsonArray = jsonData.getJSONArray("reading" + i);
    ArrayList<ArrayList<Integer>> dataArrays = new ArrayList<ArrayList<Integer>>();
    for (int j = 0; j < jsonArray.size(); j++) {
      JSONArray innerArray = jsonArray.getJSONArray(j);
      ArrayList<Integer> data = new ArrayList<Integer>();
      for (int k = 0; k < innerArray.size(); k++) {
        data.add(innerArray.getInt(k));
      }
      dataArrays.add(data);
    }
    allDataArrays.add(dataArrays);
  }
}

void saveDataArrays() {
  JSONObject jsonData = new JSONObject();
  
  for (int k = 0; k < allDataArrays.size(); k++) {
    JSONArray jsonArray = new JSONArray();
    ArrayList<ArrayList<Integer>> dataArrays = allDataArrays.get(k);
    for (int i = 0; i < dataArrays.size(); i++) {
      ArrayList<Integer> data = dataArrays.get(i);
      JSONArray innerArray = new JSONArray();
      for (int j = 0; j < data.size(); j++) {
        innerArray.append(data.get(j));
      }
      //jsonArray.setJSONArray(i, innerArray);
      jsonArray.setJSONArray(i, innerArray);
    }
    jsonData.setJSONArray("reading" + k, jsonArray);
  }
  
  saveJSONObject(jsonData, dataFilePath);
  saveDataComplete = true;
}
