// var continentsQuery = r'''
// query{
//   getUserList{
//     id
//     name
//   }
// }
//  ''';
var continentsQuery = """
query continentsQuery(\$code:ID!){
  continent(code:\$code){
    countries{
      code
      name
    }
  }
 }
 """;

var registrationQuery = r'''
mutation{
  register(data:{
    name:"",
    email:"",
    password:""
  }){
    id
    name
    email
  }
}
''';

var uploadFile = """
mutation UploadFile(\$reference: String!, \$referenceId: Int!, \$file: Upload!) {
    uploadImg(reference: \$reference, referenceId: \$referenceId, files: \$file) {
        status
        data {
            fileData {
                id
                fullPath
                dominantColor
            }
        }
        message
    }
}
""";
