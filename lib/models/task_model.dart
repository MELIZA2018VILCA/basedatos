class taskModel{
  int id;
  String title;
  String descripcion;
  String status;  

  taskModel({
    required this.id,
    required this.title,
    required this.descripcion,
    required this.status,
    });

    factory taskModel.deMapAModel (Map<String, dynamic>mapa) => taskModel(
      id: mapa["id"], 
      title: mapa["title"], 
      descripcion: 
      mapa["descripcion"], 
      status: mapa["status" ]);
}