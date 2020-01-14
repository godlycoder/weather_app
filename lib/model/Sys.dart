class Sys {
    String pod;

    Sys({this.pod});

    factory Sys.fromJson(Map<String, dynamic> json) {
        return Sys(
            pod: json['pod'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['pod'] = this.pod;
        return data;
    }
}