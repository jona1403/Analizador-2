import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { Codigoar } from 'src/app/models/codigoar/codigoar';
import { EditorService } from '../../editor/editor.service'

@Component({
  selector: 'app-editor',
  templateUrl: './editor.component.html',
  styleUrls: ['./editor.component.css']
})
export class EditorComponent implements OnInit {

  codigo = new FormControl('')
  salida = new FormControl('')
  mostrarMensaje = false
  mostrarMensajeError = false

  constructor(private ccodigoServicio: EditorService) { }

  ngOnInit(): void {
  }

  analizar_codigo(){
    //console.log(this.codigo.value);
    const ed: Codigoar = {
      cod: this.codigo.value
    }

    this.ccodigoServicio.postCodigo(ed).subscribe((res:any)=>{
      //this.mostrarMensaje = true
    },(err)=>{
      this.mostrarMensajeError = true
    })
  }

  desactivarMensaje(){
    this.mostrarMensaje = false;
    this.mostrarMensajeError = false;
  }

}

