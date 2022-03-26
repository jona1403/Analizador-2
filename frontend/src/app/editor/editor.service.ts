import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { baseURL } from '../../app/appURL/baseURL'
import { Observable } from 'rxjs';
import { Codigoar } from '../models/codigoar/codigoar'

@Injectable({
  providedIn: 'root'
})
export class EditorService {

  constructor(private http: HttpClient) {

  }

  postCodigo(codigo:Codigoar):Observable<any>{
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json'
      }),
    };
    return this.http.post<any>(baseURL+'cargarCodigo', codigo, httpOptions)
  }
  
}
