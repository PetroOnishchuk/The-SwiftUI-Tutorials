package main

type User struct {
	Id         int    `json:"id"`
	Email      string `json:"email"`
	First_name string `json:"first_name"`
	Last_name  string `json:"last_name"`
	Avatar     string `json:"avatar"`
}

var Users = []User{
	{Id: 7, Email: "michael.lawson@reqres.in", First_name: "Michael", Last_name: "Lawson", Avatar: "https://reqres.in/img/faces/7-image.jpg"},
	{8, "lindsay.ferguson@reqres.in", "Lindsay", "Ferquson", "https://reqres.in/img/faces/8-image.jpg"},
	{9, "tobias.funke@reqres.in", "Tobias", "Funke", "https://reqres.in/img/faces/9-image.jpg"},
	{10, "byron.fields@reqres.in", "Byron", "Fields", "https://reqres.in/img/faces/10-image.jpg"},
	{11, "george.edwards@reqres.in", "George", "Edwards", "https://reqres.in/img/faces/11-image.jpg"},
	{12, "rachel.howell@reqres.in", "Rachel", "Howell", "https://reqres.in/img/faces/12-image.jpg"},
}
