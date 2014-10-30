<?php
############################################################
###### Extrator de dados de ARs lidas do Sistema IBI #######
###### Por: Marcos Regis <marcos.regis@address.com.br> #####
###### Criado em: 08/SETEMBRO/2014 	########################
##### Função: Automatizar processo de extração de dados ####
#### a serem enviados via Connect Direct para o Bradesco ###
##### Versão: 0.1	########################################
############################################################

# Constantes de acesso ao Banco de Dados
define('IBI_HOSTNAME', 	'192.168.100.20'); 	// host
define('IBI_DBNAME',	'dbdevibi');		// Nome do Banco
define('IBI_DBUSER',	'valdires');		// Nome de Usuário
define('IBI_DBPASS',	'val.234');			// Senha de Acesso
define('IBI_DBPORT',	'5432');			// Porta acesso ao BD
define('IBI_FACDIR',	'/tmp'); // Diretório de destino para arquivo de FAC
define('IBI_FACFILE',	'ADDRESS2ACC.CARTAO.FAC.%s.tmp'); // Nome base do arquivo de FAC
define('IBI_LOGFILE',	'fac_extractor.log'); // Nome base do arquivo de Log
define('IBI_LOGDIR',	'./'); // Diretório de destino arquivo de log

# Variáveis 
$_ENV['scriptvars'] = array();

##### LOG
function get_log_file() {
	if (!isset($_ENV['scriptvars']['logfile'])) {
		if (is_writable(IBI_LOGDIR)) {		
			$filename = IBI_LOGDIR . IBI_LOGFILE;
		} else {
			print 'Cannot write logfile at [' . IBI_LOGDIR .'] ' . "\n";
			print 'Trying temp dir' . "\n";
			try {
				$filename = sys_get_temp_dir()  . DIRECTORY_SEPARATOR . IBI_LOGFILE;
			} catch (Exception $e) {
				print $e->getMessage() . "\n";
			}
		}
		if (!is_file($filename)) {
			try {
				file_put_contents($filename, '###### ' . date('M d H:i:s') . ' ' . php_uname('n') . ' ' . basename(__FILE__) . ': [INFO] Log File Created #####');				
				print 'Log file at ' . dirname($filename) . "\n";
			} catch (Exception $e) {				
				print $e->getMessage();
				print '[ERROR] Cannot Create Log File' . "\n";
				exit;
			}			
		}
		$_ENV['scriptvars']['logfile'] = $filename;
	}	

	return $_ENV['scriptvars']['logfile'];
}

function message2log($message, $mode = 'INFO', $file = '') {
	if ($file == '' ) {
		$file = get_log_file();
	}
	file_put_contents($file, date('M d H:i:s') . ' ' . php_uname('n') . ' ' . basename(__FILE__) . ': [' . $mode . '] ' . $message . "\r\n", FILE_APPEND);					
	print $message . "\n";
}
######## END LOG


######## FAC FILE

######## END FAC FILE
// String de conexão1
$dsn = sprintf('pgsql:host=%s;port=%d;dbname=%s;user=%s;password=%s',
			IBI_HOSTNAME, IBI_DBPORT, IBI_DBNAME, IBI_DBUSER, IBI_DBPASS);

// Criando uma conexão
try {
	message2log('Creating BD Connection');	
	$pdo = new PDO($dsn, $user, $password, array());
	message2log('SUCCESS');
	message2log('Connected using the following DSN = ' . str_replace(IBI_DBPASS, str_repeat('*', strlen(IBI_DBPASS)),$dsn));
} catch (PDOException  $e) {
	message2log($e->getMessage(), 'ERROR');
	print $e->getMessage();
}			

message2log('Looking for data to be extracted');
$sqlcount = 'SELECT COUNT(1) as qt FROM cea_controle_devolucoes WHERE DATA = CURRENT_DATE'; 
$stmt = $pdo->prepare($sqlcount);
$stmt->execute();
$result = $stmt->fetch(PDO::FETCH_ASSOC);
if (isset($result['qt']) && $result['qt'] > 0) {
	message2log('Found ' . number_format($result['qt'], 0, ',', '.') . ' entries.');
	message2log('Preparing new file for records');		
	$sql = "SELECT (nro_conta || '007' || cd_motivo || replace(dt_devolucao,'-','')) AS linha \n" . 
			"FROM cea_controle_devolucoes WHERE DATA = CURRENT_DATE";
	message2log('Preparing query...');
	$stmt = $pdo->prepare($sql);
	message2log('Retrieving all rows.');
	$stmt->execute();
	$facfile = IBI_FACDIR . DIRECTORY_SEPARATOR . sprintf(IBI_FACFILE, date('Ymd'));
	while (is_file($facfile)) { // Evitando colisão de nomes
		message2log('File ' . $facfile . ' already exists. Trying another name.', 'WARNING');
		$facfile = IBI_FACDIR . DIRECTORY_SEPARATOR . sprintf(IBI_FACFILE, date('Ymd-His'));
	}	
	try {
		message2log('Opening file ' . $facfile .' to write records.');
		$handle = fopen($facfile, 'wb');	
		$bytes = 0;
		$lines = 0;
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {			
			$b = fwrite($handle, $row['linha'] . "\r\n");
			if ($b === FALSE) {			
				message2log('Error while writing to file ' . $facfile, 'ERROR');
				print 'An error occur writing data. Aborting';				
				break;
			}
			$bytes += $b;
			$lines++;
		}
		fclose($handle);
		message2log('Summary: Written ' . $bytes . ' Bytes. ' . $lines . ' lines');
	} catch(Exception $e) {
		message2log('Fatal error', 'ERROR');
		message2log($e->getMessage());
	}

} else {
	message2log('No data to be extracted.');
}

print 'End of execution [' . date('Y-m-d H:i:s') . ']';
