angular.module('libraryMgmt')
    .controller('BookCtrl',["$scope","$mdDialog","$http",function($scope,$mdDialog,$http){
       
        $scope.showPrompt = function(tuple) {
            console.log(JSON.stringify(tuple))           
          if(tuple.length == 1){
                if(tuple[0][3].value =="Yes"){
					console.log("i'm in dialogue");
                    var confirm = $mdDialog.prompt()						
                        .title("If you like to check out this book, please enter card ID")
                        .placeholder('Card Id')
                        .ariaLabel('Card Id')
                        .required(true)
                        .ok('Check Out')
                        .cancel('Cancel');
                    $mdDialog.show(confirm).then(function(result) {                        
                        $http({
                            method:'POST',
                            url:"http://localhost:8080/libmanagement-1.0-SNAPSHOT/bookloan/bookcheckout",
                            params:{cardID:result,isbn:tuple[0][0].value}
                        }).then(function successCallback(response) {
                           $mdDialog.show(
                               $mdDialog.alert()
                                   .clickOutsideToClose(true)
                                   .textContent(response.data.message)
                                   .ok('Exit')
                           )
                        })
                    }, function() {

                    });
                }else{
                    $mdDialog.show(
                        $mdDialog.alert()
                            .clickOutsideToClose(true)
                            .title('Error')
                            .textContent('This book is nott avaialable')
                            .ok('OK')
                    );
                }
          }
        };

        $scope.bookList = [];

        $scope.searchBook = function (event) {
            if(event.which === 13){
                $scope.bookList = [];
                $http({
                    method: 'GET',
                    url: 'http://localhost:8080/libmanagement-1.0-SNAPSHOT/book/allbooks?searchString='+$scope.filterText
                }).then(function successCallback(response) {
                    if(response.data.statusCode == 200){
                        var payload = response.data.payLoad
                        angular.forEach(payload,function(item){
                            var book = {}
                            book.Isbn = item.bookIsbn;
                            book.Title = item.bookTitle;
                            var authorname = "";
                            angular.forEach(item.bookAuthors, function(author){
                                if(authorname == ""){
                                    authorname = author.bookAuthorName;
                                }else{
                                    authorname = authorname+", "+author.bookAuthorName
                                }
                            })
                            book.Authors = authorname;
                            book.Availibility = item.available?"Yes":"No";
                            $scope.bookList.push(book);
                        })
                    }else{
                        $mdDialog.show(
                            $mdDialog.alert()
                                .clickOutsideToClose(true)
                                .textContent(response.data.message)
                                .ok('OK')
                        );
                    }

                })
            }
        }

    }]);
