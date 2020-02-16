using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace BankApp.db
{
    class DB
    {
        SqlConnection conn;

        public void OpenConnection(string connStr)
        {
            conn = new SqlConnection(connStr);
            conn.Open();
        }

        public void CloseConnection()
        {
            conn.Close();
        }

        public string IsEmployee(string login, string password)
        {
            using (SqlCommand cmd = new SqlCommand("IsEmployee", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                cmd.Parameters.AddWithValue("@password", password);
                var reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        if (reader.GetValue(0).Equals(1))
                            return "Employee";
                        else if (reader.GetValue(0).Equals(2))
                            return "Admin";
                        else
                            return "";
                    }
                }
                reader.Close();
            }
            return "";
        }

        public string IsClient(string login, string password)
        {
            using (SqlCommand cmd = new SqlCommand("IsClient", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                cmd.Parameters.AddWithValue("@password", password);
                var reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        if (reader.GetValue(0).Equals(0))
                            return "Client";
                        else
                            return "";
                    }
                }
                reader.Close();
            }
            return "";
        }
        
        public List<int> GetClientAccounts(string custLogin)
        {
            var result = new List<int>();
            using (SqlCommand cmd = new SqlCommand("GetClientAccounts", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@custLogin", custLogin);
                var reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        result.Add(reader.GetInt32(0));
                    }
                }
                reader.Close();
            }
            return result;
        }

        public List<int> GetTempTransactions(string login)
        {
            var result = new List<int>();
            using (SqlCommand cmd = new SqlCommand("GetTempTransactions", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                var reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        result.Add(reader.GetInt32(0));
                    }
                }
                reader.Close();
            }
            return result;
        }
        
        public List<string> GetOneEmployee(string login)
        {
            var result = new List<string>();
            using (SqlCommand cmd = new SqlCommand("GetOneEmployee", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                var reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        result.Add(reader.GetString(3));
                        result.Add(reader.GetString(6));
                        result.Add(reader.GetString(5));
                    }
                }
                reader.Close();
            }
            return result;
        }
        
        public List<string> GetOneClient(string login)
        {
            var result = new List<string>();
            using (SqlCommand cmd = new SqlCommand("GetOneClient", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                var reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        result.Add(reader.GetString(3));
                        result.Add(reader.GetString(4));
                        result.Add(reader.GetString(5));
                        result.Add(reader.GetString(6));
                        result.Add(reader.GetString(7));
                    }
                }
                reader.Close();
            }
            return result;
        }

        public List<string> GetAllCurrency()
        {
            var result = new List<string>();
            using (SqlCommand cmd = new SqlCommand("GetAllCurrency", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                var reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        result.Add(reader.GetString(1));
                    }
                }
                reader.Close();
            }
            return result;
        }

        public List<string> GetAllBranches()
        {
            var result = new List<string>();
            using (SqlCommand cmd = new SqlCommand("GetAllBranches", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                var reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        result.Add(reader.GetString(1));
                    }
                }
                reader.Close();
            }
            return result;
        }

        public List<string> GetAllDepartments()
        {
            var result = new List<string>();
            using (SqlCommand cmd = new SqlCommand("GetAllDepartments", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                var reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        result.Add(reader.GetString(1));
                    }
                }
                reader.Close();
            }
            return result;
        }

        public List<string> GetAllRegions()
        {
            var result = new List<string>
            {
                "Брестская", "Витебская", "Гомельская", "Гродненская", "Минская", "Могилевская"
            };

            return result;
        }

        public string AddIndividualClient(string login, string password, string firstName, string lastName, DateTime? birth, string region, string city, string address)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("AddIndividualClient", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@firstName", firstName);
                cmd.Parameters.AddWithValue("@lastName", lastName);
                cmd.Parameters.AddWithValue("@birth", birth);
                cmd.Parameters.AddWithValue("@region", region);
                cmd.Parameters.AddWithValue("@city", city);
                cmd.Parameters.AddWithValue("@address", address);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string AddBusinessClient(string login, string password, string name, DateTime? incDate, string region, string city, string address)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("AddBusinessClient", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@incDate", incDate);
                cmd.Parameters.AddWithValue("@region", region);
                cmd.Parameters.AddWithValue("@city", city);
                cmd.Parameters.AddWithValue("@address", address);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }
        
        public string AddEmployee(string login, string password, string firstName, string lastName, string position, DateTime? start, string branch, string department)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("AddEmployee", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@firstName", firstName);
                cmd.Parameters.AddWithValue("@lastName", lastName);
                cmd.Parameters.AddWithValue("@position", position);
                cmd.Parameters.AddWithValue("@start", start);
                cmd.Parameters.AddWithValue("@branch", branch);
                cmd.Parameters.AddWithValue("@department", department);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string AddBranch(string name, string region, string city, string address, int index)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("AddBranch", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@region", region);
                cmd.Parameters.AddWithValue("@city", city);
                cmd.Parameters.AddWithValue("@address", address);
                cmd.Parameters.AddWithValue("@index", index);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string AddProduct(string name)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("AddProduct", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", name);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string AddDepartment(string name)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("AddDepartment", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", name);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string AddAccount(string login, string branch, float balance, string currency)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("AddAccount", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                cmd.Parameters.AddWithValue("@branch", branch);
                cmd.Parameters.AddWithValue("@balance", balance);
                cmd.Parameters.AddWithValue("@currency", currency);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string UpdEmployee(string login, string position, string branch, string depart)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("UpdEmployee", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                cmd.Parameters.AddWithValue("@position", position);
                cmd.Parameters.AddWithValue("@branch", branch);
                cmd.Parameters.AddWithValue("@depart", depart);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string UpdSuperior(string login, string branch, string depart)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("UpdSuperior", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                cmd.Parameters.AddWithValue("@branch", branch);
                cmd.Parameters.AddWithValue("@depart", depart);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string UpdCustomer(string login, string region, string city, string address)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("UpdCustomer", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                cmd.Parameters.AddWithValue("@region", region);
                cmd.Parameters.AddWithValue("@city", city);
                cmd.Parameters.AddWithValue("@address", address);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string DelBranch(string name)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("DelBranch", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", name);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string DelDepartment(string name)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("DelDepartment", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", name);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string DelEmployee(string login)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("DelEmployee", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@login", login);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string DelAccount(int id)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("DelAccount", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string DelTempTransaction(int id)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("DelTempTransaction", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string CreateCard(int accountId)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("CreateCard", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@accountId", accountId);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string DelCard(int accountId)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("DelCard", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@accId", accountId);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string PutMoney(int accountId, float amount)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("PutMoney", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@accountId", accountId);
                cmd.Parameters.AddWithValue("@amount", amount);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string WithdrawMoney(int accountId, float amount)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("WithdrawMoney", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@accountId", accountId);
                cmd.Parameters.AddWithValue("@amount", amount);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string TransYourself(int fromId, float amount, int toId)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("TransYourself", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fromId ", fromId);
                cmd.Parameters.AddWithValue("@amount", amount);
                cmd.Parameters.AddWithValue("@toId ", toId);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string TransAnother(int fromId, float amount, int toId)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("TransAnother", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fromId ", fromId);
                cmd.Parameters.AddWithValue("@amount", amount);
                cmd.Parameters.AddWithValue("@toId ", toId);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string TransExchange(int fromId, float amount, int toId)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("TransExchange", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fromId ", fromId);
                cmd.Parameters.AddWithValue("@amount", amount);
                cmd.Parameters.AddWithValue("@toId ", toId);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string TakeCredit(int accountId, float amount, DateTime end)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("TakeCredit", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@accountId ", accountId);
                cmd.Parameters.AddWithValue("@amount", amount);
                cmd.Parameters.AddWithValue("@end ", end);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string PayCredit(int accountId, float amount, int transId)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("PayCredit", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@accountId ", accountId);
                cmd.Parameters.AddWithValue("@amount", amount);
                cmd.Parameters.AddWithValue("@transId  ", transId);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }

        public string CloseCredit(int accountId, int transId)
        {
            string result;
            using (SqlCommand cmd = new SqlCommand("CloseCredit", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@accountId ", accountId);
                cmd.Parameters.AddWithValue("@transId  ", transId);
                var mess = new SqlParameter("@mess", SqlDbType.NVarChar, 200)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(mess);
                cmd.ExecuteNonQuery();
                result = cmd.Parameters["@mess"].Value.ToString();
            }
            return result;
        }
    }
}
