//
//  LigacaoTelefonica.swift
//  Agenda
//
//  Created by Renilson Moreira Ferreira on 22/03/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class LigacaoTelefonica: NSObject {

    func fazLigacao(_ alunoSelecionado:Aluno){
        guard let numeroDoAluno = alunoSelecionado.telefone else { return }
        if let url = URL(string: "tel://\(numeroDoAluno)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

    }

    
}
