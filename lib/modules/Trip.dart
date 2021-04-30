class Trip{
   String title;
   DateTime startTime;
   DateTime endTime;
   double budget;
   String tripType;

  Trip(this.title,this.startTime,this.endTime,this.budget,this.tripType);

  Map<String, dynamic> toJson() =>{
     'title':title,
     'starttime':startTime,
     'endtime':endTime,
     'budget':budget,
     'triptype':tripType
  };
}