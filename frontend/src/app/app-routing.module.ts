import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { EditorComponent } from './componentes/editor/editor.component';

const routes: Routes = [
  {
    path: '',
    component: EditorComponent,
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
