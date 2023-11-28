/* eslint-disable no-unused-vars */
import React, {
    createContext, ReactNode, useContext, useEffect, useState
} from 'react';
import api from '../services/api';

interface IUser {
    name: string,
    id: string,
    email: string
}
interface IAuthContextData {
    signed: boolean;
    user: IUser | null;
    login(user: object): Promise<void>;
    Logout(): void;
}

interface BaseLayoutProps {
    children: ReactNode;
}

const AuthContext = createContext({} as IAuthContextData);

export const AuthProvider: React.FunctionComponent<BaseLayoutProps> = ({ children }) => {
    const [user, setUser] = useState<IUser | null>(null);

    function verifyAuthenticated() {
        const storagedToken = sessionStorage.getItem('@App:token');

        if (storagedToken) {
            if (storagedToken === undefined) {
                sessionStorage.clear();
            }

            api.defaults.headers.common.Authorization = `Bearer ${storagedToken}`;
        }
    }

    useEffect(() => {
        verifyAuthenticated();
    }, []);

    async function login(userData: object) {
        const response = await api.post('/login', userData);
        if (response.data.Error) {
            // eslint-disable-next-line no-alert
            window.alert(`Ocorreu um erro: ${response.data.Error}`);
        } else {
            api.defaults.headers.common.Authorization = `Bearer ${response.data.logged.token}`;
            sessionStorage.setItem('@App:token', response.data.logged.token);
            setUser(response.data.logged.data);

            verifyAuthenticated();
        }
    }

    function Logout() {
        sessionStorage.clear();
        setUser(null);
    }

    return (
        <AuthContext.Provider value={{
            signed: Boolean(user), user, login, Logout
        }}
        >
            {children}
        </AuthContext.Provider>
    );
};

// eslint-disable-next-line react-refresh/only-export-components
export function useAuth() {
    const context = useContext(AuthContext);
    return context;
}
