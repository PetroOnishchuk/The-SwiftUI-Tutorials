package main

type UserForm struct {
	Job  string `json:"job"`
	Name string `json:"name"`
}

type PostUser struct {
	Name      string `json:"name"`
	Job       string `json:"job"`
	Id        string `json:"id"`
	CreatedAt string `json:"createdAt"`
}

var PostUsers = []PostUser{
	{Name: "morpheus", Job: "leader", Id: "128", CreatedAt: "2022-04-06T14:39:01.702Z"},
	{Name: "mary", Job: "developer", Id: "134", CreatedAt: "2021-02-06T10:10:00.230Z"},
	{Name: "ron", Job: "manager", Id: "637", CreatedAt: "2020-04-08T10:08:06.230Z"},
	{Name: "erica", Job: "developer", Id: "123", CreatedAt: "2008-08-02T15:10:07.230Z"},
	{Name: "lisa", Job: "recruiter", Id: "568", CreatedAt: "2008-08-02T15:10:07.230Z"},
}
