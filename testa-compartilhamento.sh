#!/bin/bash

#######################################################
#                                                     #
#    Script para teste de compartilhamentos windows   #
#                                                     #
#-----------------------------------------------------#
# Esse script efetua uma copia de um determinado      #
# arquivo para testar existencia de compartilhamento  #
# windows montado no linux                            #
#-----------------------------------------------------#
#                                                     #
# Criado/Atualizado em: 10/04/2017#
# Por: Cristian Martins Caetano                       #
#                      						 #
# Email: cristiancaetano@gmail.com                    #
#                                                     #
#######################################################


# VARIAVEIS DE AMBIENTE -----------------------------------------------------------------------------------------------------------


     LOG="/var/log/mont-backup.log"                                             	# ARQUIVO DE LOG

     ARQUIVO="TESTE.TXT"                                                        	# ARQUIVO A SER COPIADO PARA TESTE

     DATA=`date +%d/%m/%Y-%H:%M`                                                	# DATA E HORA

#     EMAIL="email@seudominio.com"                                               		# CONTA QUE RECEBERA E-MAIL COM DADOS DA MONTAGEM

     ASSUNTO="Teste de Montagem Compartilhamento"                                   	# ASSUNTO DO E-MAIL

     PMONTAGEM='/mnt/backup'                                                    	# PONTO DE MONTAGEM NO SERVIDOR LINUX

     PDESTINO='/home/admin/'                                                    	# PASTA PARA ONDE SERA COPIADO O ARQUIVO TESTE

     PCOMP='//ipservidor/nomecompartilhamento'                                            	# COMPARTILHAMENTO WINDOWS

     USER="usuario do compartilhamento"                                                           	# USUARIO DO COMPARTILHAMENTO WINDOWS

     SENHA="senha do compartilhamento"                                                             	# SENHA DO COMPARTILHAMENTO

     MOUNTTAF="mount -t smbfs -o username=$USER,password=$SENHA $PCOMP $PMONTAGEM"    	# COMANDO PARA MONTAGEM DO COMPARTILHAMENTO

     UMOUNTTAF="umount $PMONTAGEM"                                              	# COMANDO PARA DESMONTAR COMPARTILHAMENTO

# EXECUCAO DE TAREFAS DO SCRIPT --------------------------------------------------------------------------------------------------


   echo "" |tee -a $LOG

   echo "$DATA - Limpando arquivo de LOG" | tee -a $LOG

   echo "" |tee -a $LOG

   cat /dev/null > $LOG

   echo "$DATA - Executando Teste de Montagem de Compartilhamento" |tee -a $LOG

   echo "" |tee -a $LOG

   echo "$DATA - Efetuando tarefa de copia de arquivo para testar Compartilhamento Remoto" | tee -a $LOG

   echo "" | tee -a $LOG

   cp  $PMONTAGEM/$ARQUIVO $PDESTINO >> /dev/null

VAR=$?

       if [ $VAR -eq 0 ]

        then

                echo "$DATA - Compartilhamento  ESTA MONTADO!"

                echo ""

                df -h

                echo ""

        else

                echo "" | tee -a $LOG

                echo "$DATA - Compartilhamento NAO ESTA MONTADO, efetuando tarefa de montagem." | tee -a $LOG

                $UMOUNTTAF | tee -a $LOG

                echo "" |tee -a $LOG

                $MOUNTTAF | tee -a $LOG

                df -h  | tee -a $LOG

                echo "" |tee -a $LOG

                echo "$DATA - Compartilhamento Montado com Sucesso!" | tee -a $LOG

                echo "" | tee -a $LOG

                echo "$DATA - Enviando E-mail com informacoes sobre montagem de dispositivo."

                #echo "" | tee -a $LOG

                #echo "" | mutt -i $LOG -s $ASSUNTO $EMAIL

        fi

exit 0
