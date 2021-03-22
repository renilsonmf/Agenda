//
//  Repositorio.swift
//  Agenda
//
//  Created by Renilson Moreira Ferreira on 22/03/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {
    
    func recuperaAlunos(completion:@escaping(_ listaDeAlunos: Array<Aluno>) -> Void){
        var alunos = AlunoDAO().recuperaAlunos()
        if alunos.count == 0{
            AlunoAPI().recuperaAlunos(){
                alunos = AlunoDAO().recuperaAlunos()
                completion(alunos)
            }
        }
        else{
            completion(alunos)
        }
    }
    
    func salvaAluno(aluno:Dictionary<String, String>){
         AlunoAPI().salvaAlunosNoServidor(parametros: [aluno])
        AlunoDAO().SalvaAluno(dicionarioDeAluno: aluno)
    }
    
    func deletaAluno(aluno:Aluno){
        guard let id = aluno.id else{return}
        AlunoAPI().deletaAluno(id: String(describing: id).lowercased())
        AlunoDAO().deletaAluno(aluno: aluno)
    }
    
    // caso fique sem conexão esse metodo retorna todos os cadastros quando a conexão com o servidor voltar
    func sincronizaAlunos(){
        let alunos = AlunoDAO().recuperaAlunos()
        var listaDeParametros: Array<Dictionary<String, String>> = []
        for aluno in alunos{
            guard let id = aluno.id else{return}
            let parametros:Dictionary<String, String> = [
                "id" : String(describing: id).lowercased(),
                "nome" : aluno.nome ?? "",
                "endereco" : aluno.endereco ?? "",
                "telefone" : aluno.telefone ?? "",
                "site" : aluno.site ?? "",
                "note" : "\(aluno.nota)"
            ]
            listaDeParametros.append(parametros)
        }
        AlunoAPI().salvaAlunosNoServidor(parametros: listaDeParametros)
    }

}
