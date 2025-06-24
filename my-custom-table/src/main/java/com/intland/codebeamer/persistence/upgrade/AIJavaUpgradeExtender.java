package com.intland.codebeamer.persistence.upgrade;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.commons.lang.reflect.FieldUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import com.intland.codebeamer.dbschema.model.DataType;
import com.intland.codebeamer.dbschema.model.table.ColumnDefinition;
import com.intland.codebeamer.dbschema.model.table.TableDefinition;
import com.intland.codebeamer.persistence.rdbms.DatabaseProviderFactory;
import com.intland.codebeamer.persistence.upgrade.impl.AbstractJavaDataUpgrade;

@Component
public class AIJavaUpgradeExtender implements BeanPostProcessor {

	private static final String FIELD_NAME = "upgradeClasses";

	private static final Logger logger = LogManager.getLogger(AIJavaUpgradeExtender.class);

	private ApplicationContext applicationContext;

	public AIJavaUpgradeExtender(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
	}
	
	@Override
	public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
		if (!(bean instanceof DataUpgradeProcessor)) {
			return bean;
		}
		
		try {
			
			// We will extend the tables definitions, so the schema checker will know about this table
			List<TableDefinition> tables = DatabaseProviderFactory.getProvider().getDatabaseSchema().getTables();

			TableDefinition tableDefinition = TableDefinition
					.builder("mytable", List.of(
							ColumnDefinition.builder("col1", DataType.INTEGER).sequential(true),
							ColumnDefinition.builder("col2", DataType.INTEGER)))
					.build();
			
			if (!tables.stream().anyMatch(t -> t.getName().equalsIgnoreCase(tableDefinition.getName()))) {
				tables.add(tableDefinition);				
				// Register a new upgrade to the upgradeClasses
				addJavaDataUpgrade((DataUpgradeProcessor) bean, new AITableJavaDataUpgrade(applicationContext, tableDefinition));
			} else {
				logger.info("Table is already part of database");				
			}
		
			return bean;
		} catch (Exception e) {
			logger.error("Failed to add AITableJavaDataUpgrade to the upgradeClasses", e);
			throw new IllegalStateException("Failed to add AITableJavaDataUpgrade to the upgradeClasses");
		}

	}

	public void addJavaDataUpgrade(DataUpgradeProcessor dataUpgradeProcessor, JavaDataUpgrade javaDataUpgrade)
			throws NoSuchFieldException, IllegalAccessException {
		List<JavaDataUpgrade> upgradeClasses = getUpgradeClasses(dataUpgradeProcessor);
		upgradeClasses.add(javaDataUpgrade);
		FieldUtils.writeField(dataUpgradeProcessor, FIELD_NAME, upgradeClasses, true);
	}

	private List<JavaDataUpgrade> getUpgradeClasses(DataUpgradeProcessor dataUpgradeProcessor) throws IllegalAccessException {
		return new ArrayList<JavaDataUpgrade>((List<JavaDataUpgrade>) FieldUtils.readField(dataUpgradeProcessor,
				FIELD_NAME, true));
	}
	
	class AITableJavaDataUpgrade extends AbstractJavaDataUpgrade {

		private TableDefinition tableDefinition;

		public AITableJavaDataUpgrade(ApplicationContext applicationContext, TableDefinition tableDefinition) {
			super(applicationContext);
			this.tableDefinition = tableDefinition;
		}

		@Override
		public void upgrade(ServletContext servletContext) throws Exception {
			velocityExecInTransaction("$cb.createTable('%s')".formatted(tableDefinition.getName()), "AIJavaUpgrade");
		}

		@Override
		public String getStatementId() {
			// upgrade_statements table tracks if this update is executed or not
			return "AIJavaUpgrade";
		}
		
	}
}
